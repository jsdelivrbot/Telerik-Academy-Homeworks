﻿namespace InheritanceAndPolymorphism
{
    using System.Collections.Generic;
    using System.Text;

    public abstract class Course
    {
        private IList<string> students;

        protected Course(string name, string teacherName, IList<string> students)
        {
            this.Name = name;
            this.TeacherName = teacherName;
            this.Students = students;
        }

        protected Course(string name)
        {
            this.Name = name;
        }

        public string Name { get; set; }

        public string TeacherName { get; set; }

        public IList<string> Students
        {
            get
            {
                return this.students;
            }

            set
            {
                this.students = value != null ? value : new List<string>();
            }
        }

        public override string ToString()
        {
            StringBuilder result = new StringBuilder();
            result.Append(this.Name);
            if (!string.IsNullOrEmpty(this.TeacherName))
            {
                result.Append("; Teacher = ");
                result.Append(this.TeacherName);
            }

            if (this.Students != null && this.Students.Count > 0)
            {
                result.Append("; Students = ");
                result.Append(this.GetStudentsAsString());
            }

            return result.ToString();
        }

        protected string GetStudentsAsString()
        {
            if (this.Students.Count == 0)
            {
                return "{ }";
            }

            return "{ " + string.Join(", ", this.Students) + " }";
        }
    }
}