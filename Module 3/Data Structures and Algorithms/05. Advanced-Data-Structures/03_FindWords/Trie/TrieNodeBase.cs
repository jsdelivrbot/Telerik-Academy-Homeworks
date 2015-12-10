// This code is distributed under MIT license. Copyright (c) 2013 George Mamaladze
// See license.txt or http://opensource.org/licenses/mit-license.php

namespace FindWords.Trie
{
    using System;
    using System.Collections.Generic;
    using System.Linq;

    public abstract class TrieNodeBase<TValue>
    {
        protected abstract int KeyLength { get; }

        public void Add(string key, int position, TValue value)
        {
            if (key == null)
            {
                throw new ArgumentNullException("key");
            }

            if (EndOfString(position, key))
            {
                this.AddValue(value);
                return;
            }

            TrieNodeBase<TValue> child = this.GetOrCreateChild(key[position]);
            child.Add(key, position + 1, value);
        }

        protected abstract IEnumerable<TValue> Values();

        protected abstract IEnumerable<TrieNodeBase<TValue>> Children();

        protected abstract void AddValue(TValue value);

        protected abstract TrieNodeBase<TValue> GetOrCreateChild(char key);

        protected virtual IEnumerable<TValue> Retrieve(string query, int position)
        {
            return
                EndOfString(position, query)
                    ? this.ValuesDeep()
                    : this.SearchDeep(query, position);
        }

        protected virtual IEnumerable<TValue> SearchDeep(string query, int position)
        {
            TrieNodeBase<TValue> nextNode = this.GetChildOrNull(query, position);
            return nextNode != null
                       ? nextNode.Retrieve(query, position + nextNode.KeyLength)
                       : Enumerable.Empty<TValue>();
        }

        protected abstract TrieNodeBase<TValue> GetChildOrNull(string query, int position);

        protected IEnumerable<TrieNodeBase<TValue>> Subtree()
        {
            return
                Enumerable.Repeat(this, 1)
                    .Concat(this.Children().SelectMany(child => child.Subtree()));
        }

        private static bool EndOfString(int position, string text)
        {
            return position >= text.Length;
        }

        private IEnumerable<TValue> ValuesDeep()
        {
            return 
                this.Subtree()
                    .SelectMany(node => node.Values());
        }
    }
}