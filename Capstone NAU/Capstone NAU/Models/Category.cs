﻿using System;
using System.Collections.Generic;

namespace Capstone_NAU.Models
{
    public partial class Category
    {
        public Category()
        {
            Question = new HashSet<Question>();
        }

        public string Description { get; set; }
        public string CategoryId { get; set; }

        public ICollection<Question> Question { get; set; }
    }
}
