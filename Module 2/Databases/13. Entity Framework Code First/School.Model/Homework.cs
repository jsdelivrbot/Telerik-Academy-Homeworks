﻿namespace School.Model
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;

    public class Homework
    {
        private ICollection<Student> students;
        private ICollection<Course> courses;

        public Homework()
        {
            this.students = new HashSet<Student>();
            this.courses = new HashSet<Course>();
        }

        [Key]
        public int Id { get; set; }

        public string Content { get; set; }

        public DateTime TimeSent { get; set; }

        public virtual ICollection<Student> Students
        {
            get { return this.students; }
            set { this.students = value; }
        }
        
        public virtual ICollection<Course> Courses
        {
            get { return this.courses; }
            set { this.courses = value; }
        }
    }
}
