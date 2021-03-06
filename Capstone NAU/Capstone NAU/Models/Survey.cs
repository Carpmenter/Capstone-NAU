﻿using System;
using System.Collections.Generic;

namespace Capstone_NAU.Models
{
    public partial class Survey
    {
        public Survey()
        {
            Participant = new HashSet<Participant>();
            SurveyQuestion = new HashSet<SurveyQuestion>();
            SurveyResponse = new HashSet<SurveyResponse>();
        }

        public int SurveyId { get; set; }
        public string Description { get; set; }
        public DateTime CreationDate { get; set; }

        public ICollection<Participant> Participant { get; set; }
        public ICollection<SurveyQuestion> SurveyQuestion { get; set; }
        public ICollection<SurveyResponse> SurveyResponse { get; set; }
    }
}
