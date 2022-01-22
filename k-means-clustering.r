{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "f349e703",
   "metadata": {
    "papermill": {
     "duration": 0.072326,
     "end_time": "2022-01-22T22:47:19.455619",
     "exception": false,
     "start_time": "2022-01-22T22:47:19.383293",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# Using K-Means Clustering to find teen market segments.\n",
    "\n",
    "### Presented by Edeh Emeka N.\n",
    "\n",
    "**This exercise aims at helping businesses target the correct segment of the population using teens as a case study.**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "74bde198",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-22T22:47:19.599230Z",
     "iopub.status.busy": "2022-01-22T22:47:19.598557Z",
     "iopub.status.idle": "2022-01-22T22:47:20.042820Z",
     "shell.execute_reply": "2022-01-22T22:47:20.041771Z"
    },
    "papermill": {
     "duration": 0.517879,
     "end_time": "2022-01-22T22:47:20.042971",
     "exception": false,
     "start_time": "2022-01-22T22:47:19.525092",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "sns_data<-read.csv(\"../input/snsdata/snsdata.csv\")\n",
    "#This dataset represents a random sample of 30,000 U.S High School Students who had profiles on \n",
    "#SNS in 2006. The real identities of the students are not revealed."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "f0189682",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-22T22:47:20.213126Z",
     "iopub.status.busy": "2022-01-22T22:47:20.180490Z",
     "iopub.status.idle": "2022-01-22T22:47:20.250052Z",
     "shell.execute_reply": "2022-01-22T22:47:20.249413Z"
    },
    "papermill": {
     "duration": 0.140127,
     "end_time": "2022-01-22T22:47:20.250202",
     "exception": false,
     "start_time": "2022-01-22T22:47:20.110075",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t30000 obs. of  40 variables:\n",
      " $ gradyear    : int  2006 2006 2006 2006 2006 2006 2006 2006 2006 2006 ...\n",
      " $ gender      : chr  \"M\" \"F\" \"M\" \"F\" ...\n",
      " $ age         : num  19 18.8 18.3 18.9 19 ...\n",
      " $ friends     : int  7 0 69 0 10 142 72 17 52 39 ...\n",
      " $ basketball  : int  0 0 0 0 0 0 0 0 0 0 ...\n",
      " $ football    : int  0 1 1 0 0 0 0 0 0 0 ...\n",
      " $ soccer      : int  0 0 0 0 0 0 0 0 0 0 ...\n",
      " $ softball    : int  0 0 0 0 0 0 0 1 0 0 ...\n",
      " $ volleyball  : int  0 0 0 0 0 0 0 0 0 0 ...\n",
      " $ swimming    : int  0 0 0 0 0 0 0 0 0 0 ...\n",
      " $ cheerleading: int  0 0 0 0 0 0 0 0 0 0 ...\n",
      " $ baseball    : int  0 0 0 0 0 0 0 0 0 0 ...\n",
      " $ tennis      : int  0 0 0 0 0 0 0 0 0 0 ...\n",
      " $ sports      : int  0 0 0 0 0 0 0 0 0 0 ...\n",
      " $ cute        : int  0 1 0 1 0 0 0 0 0 1 ...\n",
      " $ sex         : int  0 0 0 0 1 1 0 2 0 0 ...\n",
      " $ sexy        : int  0 0 0 0 0 0 0 1 0 0 ...\n",
      " $ hot         : int  0 0 0 0 0 0 0 0 0 1 ...\n",
      " $ kissed      : int  0 0 0 0 5 0 0 0 0 0 ...\n",
      " $ dance       : int  1 0 0 0 1 0 0 0 0 0 ...\n",
      " $ band        : int  0 0 2 0 1 0 1 0 0 0 ...\n",
      " $ marching    : int  0 0 0 0 0 1 1 0 0 0 ...\n",
      " $ music       : int  0 2 1 0 3 2 0 1 0 1 ...\n",
      " $ rock        : int  0 2 0 1 0 0 0 1 0 1 ...\n",
      " $ god         : int  0 1 0 0 1 0 0 0 0 6 ...\n",
      " $ church      : int  0 0 0 0 0 0 0 0 0 0 ...\n",
      " $ jesus       : int  0 0 0 0 0 0 0 0 0 2 ...\n",
      " $ bible       : int  0 0 0 0 0 0 0 0 0 0 ...\n",
      " $ hair        : int  0 6 0 0 1 0 0 0 0 1 ...\n",
      " $ dress       : int  0 4 0 0 0 1 0 0 0 0 ...\n",
      " $ blonde      : int  0 0 0 0 0 0 0 0 0 0 ...\n",
      " $ mall        : int  0 1 0 0 0 0 2 0 0 0 ...\n",
      " $ shopping    : int  0 0 0 0 2 1 0 0 0 1 ...\n",
      " $ clothes     : int  0 0 0 0 0 0 0 0 0 0 ...\n",
      " $ hollister   : int  0 0 0 0 0 0 2 0 0 0 ...\n",
      " $ abercrombie : int  0 0 0 0 0 0 0 0 0 0 ...\n",
      " $ die         : int  0 0 0 0 0 0 0 0 0 0 ...\n",
      " $ death       : int  0 0 1 0 0 0 0 0 0 0 ...\n",
      " $ drunk       : int  0 0 0 0 1 1 0 0 0 0 ...\n",
      " $ drugs       : int  0 0 0 0 1 0 0 0 0 0 ...\n"
     ]
    }
   ],
   "source": [
    "str(sns_data)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "b89dc1d3",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-22T22:47:20.394582Z",
     "iopub.status.busy": "2022-01-22T22:47:20.393096Z",
     "iopub.status.idle": "2022-01-22T22:47:20.421865Z",
     "shell.execute_reply": "2022-01-22T22:47:20.420519Z"
    },
    "papermill": {
     "duration": 0.101089,
     "end_time": "2022-01-22T22:47:20.422010",
     "exception": false,
     "start_time": "2022-01-22T22:47:20.320921",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".dl-inline {width: auto; margin:0; padding: 0}\n",
       ".dl-inline>dt, .dl-inline>dd {float: none; width: auto; display: inline-block}\n",
       ".dl-inline>dt::after {content: \":\\0020\"; padding-right: .5ex}\n",
       ".dl-inline>dt:not(:first-of-type) {padding-left: .5ex}\n",
       "</style><dl class=dl-inline><dt>gradyear</dt><dd>0</dd><dt>gender</dt><dd>2724</dd><dt>age</dt><dd>5086</dd><dt>friends</dt><dd>0</dd><dt>basketball</dt><dd>0</dd><dt>football</dt><dd>0</dd><dt>soccer</dt><dd>0</dd><dt>softball</dt><dd>0</dd><dt>volleyball</dt><dd>0</dd><dt>swimming</dt><dd>0</dd><dt>cheerleading</dt><dd>0</dd><dt>baseball</dt><dd>0</dd><dt>tennis</dt><dd>0</dd><dt>sports</dt><dd>0</dd><dt>cute</dt><dd>0</dd><dt>sex</dt><dd>0</dd><dt>sexy</dt><dd>0</dd><dt>hot</dt><dd>0</dd><dt>kissed</dt><dd>0</dd><dt>dance</dt><dd>0</dd><dt>band</dt><dd>0</dd><dt>marching</dt><dd>0</dd><dt>music</dt><dd>0</dd><dt>rock</dt><dd>0</dd><dt>god</dt><dd>0</dd><dt>church</dt><dd>0</dd><dt>jesus</dt><dd>0</dd><dt>bible</dt><dd>0</dd><dt>hair</dt><dd>0</dd><dt>dress</dt><dd>0</dd><dt>blonde</dt><dd>0</dd><dt>mall</dt><dd>0</dd><dt>shopping</dt><dd>0</dd><dt>clothes</dt><dd>0</dd><dt>hollister</dt><dd>0</dd><dt>abercrombie</dt><dd>0</dd><dt>die</dt><dd>0</dd><dt>death</dt><dd>0</dd><dt>drunk</dt><dd>0</dd><dt>drugs</dt><dd>0</dd></dl>\n"
      ],
      "text/latex": [
       "\\begin{description*}\n",
       "\\item[gradyear] 0\n",
       "\\item[gender] 2724\n",
       "\\item[age] 5086\n",
       "\\item[friends] 0\n",
       "\\item[basketball] 0\n",
       "\\item[football] 0\n",
       "\\item[soccer] 0\n",
       "\\item[softball] 0\n",
       "\\item[volleyball] 0\n",
       "\\item[swimming] 0\n",
       "\\item[cheerleading] 0\n",
       "\\item[baseball] 0\n",
       "\\item[tennis] 0\n",
       "\\item[sports] 0\n",
       "\\item[cute] 0\n",
       "\\item[sex] 0\n",
       "\\item[sexy] 0\n",
       "\\item[hot] 0\n",
       "\\item[kissed] 0\n",
       "\\item[dance] 0\n",
       "\\item[band] 0\n",
       "\\item[marching] 0\n",
       "\\item[music] 0\n",
       "\\item[rock] 0\n",
       "\\item[god] 0\n",
       "\\item[church] 0\n",
       "\\item[jesus] 0\n",
       "\\item[bible] 0\n",
       "\\item[hair] 0\n",
       "\\item[dress] 0\n",
       "\\item[blonde] 0\n",
       "\\item[mall] 0\n",
       "\\item[shopping] 0\n",
       "\\item[clothes] 0\n",
       "\\item[hollister] 0\n",
       "\\item[abercrombie] 0\n",
       "\\item[die] 0\n",
       "\\item[death] 0\n",
       "\\item[drunk] 0\n",
       "\\item[drugs] 0\n",
       "\\end{description*}\n"
      ],
      "text/markdown": [
       "gradyear\n",
       ":   0gender\n",
       ":   2724age\n",
       ":   5086friends\n",
       ":   0basketball\n",
       ":   0football\n",
       ":   0soccer\n",
       ":   0softball\n",
       ":   0volleyball\n",
       ":   0swimming\n",
       ":   0cheerleading\n",
       ":   0baseball\n",
       ":   0tennis\n",
       ":   0sports\n",
       ":   0cute\n",
       ":   0sex\n",
       ":   0sexy\n",
       ":   0hot\n",
       ":   0kissed\n",
       ":   0dance\n",
       ":   0band\n",
       ":   0marching\n",
       ":   0music\n",
       ":   0rock\n",
       ":   0god\n",
       ":   0church\n",
       ":   0jesus\n",
       ":   0bible\n",
       ":   0hair\n",
       ":   0dress\n",
       ":   0blonde\n",
       ":   0mall\n",
       ":   0shopping\n",
       ":   0clothes\n",
       ":   0hollister\n",
       ":   0abercrombie\n",
       ":   0die\n",
       ":   0death\n",
       ":   0drunk\n",
       ":   0drugs\n",
       ":   0\n",
       "\n"
      ],
      "text/plain": [
       "    gradyear       gender          age      friends   basketball     football \n",
       "           0         2724         5086            0            0            0 \n",
       "      soccer     softball   volleyball     swimming cheerleading     baseball \n",
       "           0            0            0            0            0            0 \n",
       "      tennis       sports         cute          sex         sexy          hot \n",
       "           0            0            0            0            0            0 \n",
       "      kissed        dance         band     marching        music         rock \n",
       "           0            0            0            0            0            0 \n",
       "         god       church        jesus        bible         hair        dress \n",
       "           0            0            0            0            0            0 \n",
       "      blonde         mall     shopping      clothes    hollister  abercrombie \n",
       "           0            0            0            0            0            0 \n",
       "         die        death        drunk        drugs \n",
       "           0            0            0            0 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#i will determine the number of missing values in the columns\n",
    " sapply(sns_data, function(x) sum(is.na (x)))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "0c18a892",
   "metadata": {
    "papermill": {
     "duration": 0.039911,
     "end_time": "2022-01-22T22:47:20.502136",
     "exception": false,
     "start_time": "2022-01-22T22:47:20.462225",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**From the above output, the gender column has 2724 missing values, age column has 5086 missing values and the rest columns have no missing values.**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "2eff23c8",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-22T22:47:20.586585Z",
     "iopub.status.busy": "2022-01-22T22:47:20.585312Z",
     "iopub.status.idle": "2022-01-22T22:47:20.603348Z",
     "shell.execute_reply": "2022-01-22T22:47:20.602049Z"
    },
    "papermill": {
     "duration": 0.061347,
     "end_time": "2022-01-22T22:47:20.603489",
     "exception": false,
     "start_time": "2022-01-22T22:47:20.542142",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\n",
       "    F     M  <NA> \n",
       "22054  5222  2724 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "table(sns_data$gender, useNA =\"ifany\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "b285e152",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-22T22:47:20.693036Z",
     "iopub.status.busy": "2022-01-22T22:47:20.692395Z",
     "iopub.status.idle": "2022-01-22T22:47:20.710351Z",
     "shell.execute_reply": "2022-01-22T22:47:20.708988Z"
    },
    "papermill": {
     "duration": 0.064892,
     "end_time": "2022-01-22T22:47:20.710461",
     "exception": false,
     "start_time": "2022-01-22T22:47:20.645569",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's \n",
       "  3.086  16.312  17.287  17.994  18.259 106.927    5086 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#I will check for outliers in the age variable\n",
    "summary(sns_data$age)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "fa176660",
   "metadata": {
    "papermill": {
     "duration": 0.04107,
     "end_time": "2022-01-22T22:47:20.793966",
     "exception": false,
     "start_time": "2022-01-22T22:47:20.752896",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**I will drop ages that fall outside the range of 13 and 20 years**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "722da2f9",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-22T22:47:20.883082Z",
     "iopub.status.busy": "2022-01-22T22:47:20.881692Z",
     "iopub.status.idle": "2022-01-22T22:47:20.896591Z",
     "shell.execute_reply": "2022-01-22T22:47:20.895217Z"
    },
    "papermill": {
     "duration": 0.060901,
     "end_time": "2022-01-22T22:47:20.896711",
     "exception": false,
     "start_time": "2022-01-22T22:47:20.835810",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "sns_data$age<-ifelse(sns_data$age>=13 & sns_data$age < 20, sns_data$age, NA)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "ed80097b",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-22T22:47:20.986661Z",
     "iopub.status.busy": "2022-01-22T22:47:20.985046Z",
     "iopub.status.idle": "2022-01-22T22:47:21.008533Z",
     "shell.execute_reply": "2022-01-22T22:47:21.006942Z"
    },
    "papermill": {
     "duration": 0.069659,
     "end_time": "2022-01-22T22:47:21.008640",
     "exception": false,
     "start_time": "2022-01-22T22:47:20.938981",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's \n",
       "  13.03   16.30   17.27   17.25   18.22   20.00    5523 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "summary(sns_data$age)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "18dc085e",
   "metadata": {
    "papermill": {
     "duration": 0.043037,
     "end_time": "2022-01-22T22:47:21.094506",
     "exception": false,
     "start_time": "2022-01-22T22:47:21.051469",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**Now the ages fall within an ideal High School teenager Age**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "f6a0a807",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-22T22:47:21.186358Z",
     "iopub.status.busy": "2022-01-22T22:47:21.184768Z",
     "iopub.status.idle": "2022-01-22T22:47:21.203329Z",
     "shell.execute_reply": "2022-01-22T22:47:21.201986Z"
    },
    "papermill": {
     "duration": 0.065751,
     "end_time": "2022-01-22T22:47:21.203436",
     "exception": false,
     "start_time": "2022-01-22T22:47:21.137685",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "#creating dummy variables for females and unknown\n",
    "sns_data$female<-ifelse(sns_data$gender==\"F\" & !is.na(sns_data$gender),1,0)\n",
    "sns_data$no_gender<-ifelse(is.na(sns_data$gender),1,0)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "738a9e7c",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-22T22:47:21.294791Z",
     "iopub.status.busy": "2022-01-22T22:47:21.293300Z",
     "iopub.status.idle": "2022-01-22T22:47:21.334849Z",
     "shell.execute_reply": "2022-01-22T22:47:21.333663Z"
    },
    "papermill": {
     "duration": 0.089171,
     "end_time": "2022-01-22T22:47:21.334956",
     "exception": false,
     "start_time": "2022-01-22T22:47:21.245785",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "no_gender<-table(sns_data$no_gender, useNA=\"ifany\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "c5273e9a",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-22T22:47:21.428143Z",
     "iopub.status.busy": "2022-01-22T22:47:21.426133Z",
     "iopub.status.idle": "2022-01-22T22:47:21.446940Z",
     "shell.execute_reply": "2022-01-22T22:47:21.444672Z"
    },
    "papermill": {
     "duration": 0.069129,
     "end_time": "2022-01-22T22:47:21.447093",
     "exception": false,
     "start_time": "2022-01-22T22:47:21.377964",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\n",
       "    0     1 \n",
       "27276  2724 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "no_gender"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "id": "39d2cdbf",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-22T22:47:21.543503Z",
     "iopub.status.busy": "2022-01-22T22:47:21.542274Z",
     "iopub.status.idle": "2022-01-22T22:47:21.822761Z",
     "shell.execute_reply": "2022-01-22T22:47:21.822117Z"
    },
    "papermill": {
     "duration": 0.33124,
     "end_time": "2022-01-22T22:47:21.822866",
     "exception": false,
     "start_time": "2022-01-22T22:47:21.491626",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAIAAAByhViMAAAABmJLR0QA/wD/AP+gvaeTAAAg\nAElEQVR4nO3daXxV9Z348ZONEAmyimyyCFRQ1CoiOG6AC6hlcWbEQYrKSGv/LmBdxiooat1o\nR62KMFo3xAJq1RY11pYWHCyujIKCIEQiVoHKFiRkI8n/AZYqwvWi5F7OL+/3A1/JOcfL91k+\nr3Pvud+MmpqaCACA+MtM9wAAAOwZwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4A\nIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIO\nACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDC\nDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQ\nwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAg\nEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4A\nIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIO\nACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDC\nDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQ\nwg4AIBDCDgAgENnpHiAGiouLp0yZUlpamu5BAIC9Ql5e3nnnndeoUaN0D7IjYffNfvOb34wZ\nMybdUwAAe5Hs7OyLLroo3VPsSNh9s8rKyiiKHnroocMPPzzdswAAabZgwYILLrhgWx7sbYRd\nsg466KAePXqkewoAIM3KysrSPcIueXgCACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIO\nACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDC\nDgAgEMIupaqrq4uKiqqrq9M9CAAQIGGXOtXV1f369evYsWO/fv20HQCwxwm71Fm+fPnLL78c\n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\nURRlZje/4Lp7/nf+4rUbPz9//32+ci6j3ohx//P+6k1/+2DB7D8WpGlAAIC0idP32CUnq02X\nw9p0OSzdYwAApFrM7tgBALArwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDC\nDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQ\nwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAg\nEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4A\nIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQ2eke4FvasGrF0qXL\n1qzfVLKlLLt+g0bNWnbp2u3AVo3TPRcAQNrELOxqqoqfvOvGex6aNm/Jmq+fbdm19zmjxlw3\n5uzG2Rmpnw0AIL3iFHZVFZ+M7Hn41IXrsnKa9uo36LBunVo1b5ybm721vHzj2tUfLVs0b+7r\nd1457LFpzy949bHW9bzLDADULXEKu1evGDB14brjLrl7+u0XtW2wk8mrK9ZNn3DxiPHTTrl0\n1KL7+6R8QACAdIrTba1rpy7Lb/WTufeO3mnVRVGUWa/Z8OtmTO61f+GMcSmeDQAg7eIUdu+W\nVOa3G/iNl/U4oUXllkUpmAcAYK8Sp7Ab3Cxvw5LbV1dUJ7qouvThJ4vqN+mfqqEAAPYWcQq7\nsRP6lxfP7d576OMvzS+pqtnxdE354rnPjjql2+SiTX3Gj0/HgAAA6RSnhye6nPfUr9889cJJ\nz4wY8HRWvUYHdunUer/Gubk5VRXlxWtXfbiscH3Z1oyMjL4X3Tfz4m7pHhYAINXiFHZRlDlq\n4qzTRvzuvkemF8x+bcn7by9b9MV9u4zM3LadDjmlb/9ho0YP7tkmvVMCAKRFvMIuiqKoTa8h\nt/YacmsU1Wwt3bjx85LSinp5+zRs3CTPlxIDAHVb/MJuGyvFAAB2ELOws1IMAGBX4hR2VooB\nACQQp7CzUgwAIIE43dayUgwAIIE4hZ2VYgAACcQp7KwUAwBIIE5hZ6UYAEACcXp4wkoxAIAE\n4hR2VooBACQQr7CLIivFAAB2IX5ht42VYgAAO4hZ2FkpBgCwK3EKOyvFAAASiFPYWSkGAJBA\nnMJu+0qxXV2wbaXY5oKXx8wYF93/SjKvWVVVVVBQUFZWluCaoqKiKIqqqxN+MTIAQLrFKeze\nLanM75rcSrG3kl0pNnv27EGDBiVz5YoVK5J8TQCAtIhT2A1uljdjye2rKwa0TPD5uS9Wip2W\n5Gv27dt35syZie/YTZo0ac6cOR07dtytaQEAUixOYTd2Qv8p5z/TvffQX912zZknH9kg66uP\nvtaUL36l4M4bfvpQ0abTJya7UiwrK2vgwG+4C1hQUBBFUWampzEAgL1anMLOSjEAgATiFHZW\nigEAJBCvsIsiK8UAAHYhfmG3jZViAAA7iFnYWSkGALArcQo7K8UAABKIU9hZKQYAkECcbmtt\nXym206qL/rFSbHKv/QtnjEvxbAAAaRensHu3pDK/XXIrxbYku1IMACAYcQq7wc3yNiy5fXVF\ndaKLvlgp1j9VQwEA7C3iFHZjJ/QvL57bvffQx1+aX1JVs+PpmvLFc58ddUq3yUWb+oxPdqUY\nAEAw4vTwhJViAAAJxCnsrBQDAEggXmEXRVaKAQDsQvzCrqJ45Wvz3lj4wWetOh9y+mnHN8nc\nsecW/f6pdzZXDB8+PC3jAQCkS8zC7rUHRg+5dNKaiqptv+a37zX59wU/PLzpl6/5/WU/GltU\nLOwAgLomTmH39zduOPYnE6OsxiMuu6h315Yr33rpvkcKzj/64HrLlw89ID/d0wEApFmcwu6h\nc++JMhtMWVD4w4ObRFEUXXjJ6B/e/b2TLv/RCRcOLHw872vvyQIA1Clx+h67yUWfN+t+9xdV\nF0VRFLU+ccyfbzxmU9G0f3twaRoHAwDYG8Qp7DZXVdff74AdDh79sxcGNM+bddmgxVu2pmUq\nAIC9RJzCrl/j+p/N/8Xmr+6cyMhqNOX5a6vKlg/493u/towCAKAOiVPY/WxU17INs3oMu+G9\nT0u+fLxFr3G/HdXt4xcvP27M/cVfXzUGAFA3xCnsjrzpxWGHNf3gqZsOa9uodcfvPbuudPup\nwZPmXvuDTvPu+UnLlp0fXF2S4EUAAEIVp7DLzGnx+PylD9506XFHfK9iw6rirf+8OZeZ3fSW\nmYsf+/mFHbJWryjzYTsAoC6KU9hFUZSZ3fyC6+753/mL1278/Pz99/nKuYx6I8b9z/urN/3t\ngwWz/1iQpgEBANImTt9jl5ysNl0Oa9PlsHSPAQCQajG7YwcAwK4IOwCAQAg7AIBACDsAgEAI\nOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBA\nCDsAgEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBACDsAgEAIOwCA\nQAg7AIBACDsAgEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBACDsA\ngEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7\nAIBACDsAgEBkp3uAb2nDqhVLly5bs35TyZay7PoNGjVr2aVrtwNbNU73XAAAaROzsKupKn7y\nrhvveWjavCVrvn62Zdfe54wac92YsxtnZ6R+NgCA9IpT2FVVfDKy5+FTF67Lymnaq9+gw7p1\natW8cW5u9tby8o1rV3+0bNG8ua/feeWwx6Y9v+DVx1rX8y4zAFC3xCnsXr1iwNSF64675O7p\nt1/UtsFOJq+uWDd9wsUjxk875dJRi+7vk/IBAQDSKU63ta6duiy/1U/m3jt6p1UXRVFmvWbD\nr5sxudf+hTPGpXg2AIC0i1PYvVtSmd9u4Dde1uOEFpVbFqVgHgCAvUqcwm5ws7wNS25fXVGd\n6KLq0oefLKrfpH+qhgIA2FvEKezGTuhfXjy3e++hj780v6SqZsfTNeWL5z476pRuk4s29Rk/\nPh0DAgCkU5wenuhy3lO/fvPUCyc9M2LA01n1Gh3YpVPr/Rrn5uZUVZQXr1314bLC9WVbMzIy\n+l5038yLu6V7WACAVEsq7KorP7viv25tedxlV/9b+9oeKKHMURNnnTbid/c9Mr1g9mtL3n97\n2aIv7ttlZOa27XTIKX37Dxs1enDPNmkdEgAgPZIKu8yc/V584L6Sd09Nd9hFURS16TXk1l5D\nbo2imq2lGzd+XlJaUS9vn4aNm+T5UmIAoG5L9q3YR686/oRf/nTxllMO3mevePfWSjEAgB0k\nW2m9b/jztMwf9ju0/1XXX9K3R7emDfN2uD/Wvn0qbuZZKQYAsCvJhl1OTk4URTVVVVee/5ed\nXlBT87XHVPc0K8UAABJINuxGjRpVq3Mkw0oxAIAEkg27yZMn1+ocydi+UmxXF2xbKba54OUx\nM8ZF97+SytkAANJu956EqN66ft6fZi/8oKh4c+k1Y8eVFH2U16F9yt7yfLekMr9rcivF3rJS\n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\nNv3wqGvf6Hbx5Ocu7JruiQAA9iLxe3ji0IvvSPcIAAB7o/iFXb19jzuybctG9bPSPQgAwN4l\nTm/Fbjf/41XpHgEAYK8Tvzt2AADslLADAAiEsAMACISwAwAIhLADAAiEsAMACISwAwAIhLAD\nAAiEsAMACISwAwAIhLADAAiEsAMACISwAwAIhLADAAiEsAMACISwAwAIhLADAAiEsAMACISw\nAwAIhLADAAiEsAMACISwAwAIhLADAAiEsAMACISwAwAIhLADAAiEsAMACISwAwAIhLADAAiE\nsAMACISwAwAIhLADAAiEsAMACISwAwAIhLADAAiEsAMACISwAwAIhLADAAiEsAMACISwAwAI\nhLADAAiEsAMACISwAwAIhLADAAiEsAMACISwAwAIhLADAAiEsAMACISwAwAIhLADAAiEsAMA\nCISwAwAIhLADAAiEsAMACISwAwAIhLADAAiEsAMACER2ugf4ljasWrF06bI16zeVbCnLrt+g\nUbOWXbp2O7BV43TPBQCQNjELu5qq4ifvuvGeh6bNW7Lm62dbdu19zqgx1405u3F2RupnAwBI\nrziFXVXFJyN7Hj514bqsnKa9+g06rFunVs0b5+Zmby0v37h29UfLFs2b+/qdVw57bNrzC159\nrHU97zIDAHVLnMLu1SsGTF247rhL7p5++0VtG+xk8uqKddMnXDxi/LRTLh216P4+KR8QACCd\n4nRb69qpy/Jb/WTuvaN3WnVRFGXWazb8uhmTe+1fOGNcimcDAEi7OIXduyWV+e0GfuNlPU5o\nUbllUQrmAQDYq8Qp7AY3y9uw5PbVFdWJLqouffjJovpN+qdqKACAvUWcwm7shP7lxXO79x76\n+EvzS6pqdjxdU7547rOjTuk2uWhTn/Hj0zEgAEA6xenhiS7nPfXrN0+9cNIzIwY8nVWv0YFd\nOrXer3Fubk5VRXnx2lUfLitcX7Y1IyOj70X3zby4W7qHBQBItTiFXRRljpo467QRv7vvkekF\ns19b8v7byxZ9cd8uIzO3badDTunbf9io0YN7tknvlAAAaRGvsIuiKGrTa8itvYbcGkU1W0s3\nbvy8pLSiXt4+DRs3yfOlxABA3Ra/sNvGSjEAgB3ELOysFAMA2JU4hZ2VYgAACcQp7KwUAwBI\nIE63tawUAwBIIE5hZ6UYAEACcQo7K8UAABKIU9hZKQYAkECcHp6wUgwAIIE4hV1trBSrqqoq\nKCgoKytLcE1RUVEURdXVCd8CBgBIt3iFXRTt6ZVis2fPHjRoUDJXrlix4lu8PgBAysQv7LbZ\nUyvF+vbtO3PmzMR37CZNmjRnzpyOHTt+h3kBAGpdzMJuj68Uy8rKGjjwG75CpaCgIIqizMw4\nPWgCANRBcQo7K8UAABKIU9hZKQYAkECcbmtZKQYAkECcws5KMQCABOIUdlaKAQAkEKews1IM\nACCBOD08YaUYAEACcQq72lgpBgAQjHiFXRTt6ZViAADBiF/YbZeRndekeV6jijV/ef65hcs/\nqc5t3PWIYwccf7jAAwDqpjiFXd++ffOan1nw1OjtR5Y9e+vpI29cXlyx/Uizg0998Kknhhy8\n20tjAQDiLk5hN2fOnPzW3bf/Wrxs0vfPuq60Jqf/uZf269G9dcPovddfnPTgzKE9j5n16Tsn\nNMpN46gAAKkXp7DbwW+G3lBaXTP+Dx+MP7XdF4dG/vin597R5rirzv/PWR8+fUZapwMASLU4\nfY/dDu5YuqHhAWP/WXVRFEXR/v9yxU0dG30665Z0TQUAkC4xDru1ldX57Y/9+vGjOuRXlryX\n+nkAANIrxmF3bssGm1e++vXjc5dvysk/PPXzAACkV8zCrmx9wfkXjrn5l/fOePbFfpf2/nzl\nzdf/8eMvX7D0mWtvXrmp5fFXp2tCAIB0idPDE0cfdtDyDz+c8sA9Xz5425A+N20pjKIoqtl6\n7hnHTPvD/KzcNvc/enJ6RgQASJ84hd3rC5ZEUbRxzcrC5csLCwuXFxYWFhauWLnpH+erpr74\nVpMuJ9z9xDP9m9VP45wAAGkRp7DbpvH+7Xrs367Hsf12PJGRM+/dFb27d7B4AgCom+IXdruW\neUz3DumeAQAgbWL28AQAALsi7AAAAiHsAAACIewAAAIh7AAAAiHsAAACIewAAAIh7AAAAiHs\nAAACIewAAAIh7AAAAiHsAAACIewAAAIh7AAAAiHsAAACIewAAAIh7AAAAiHsAAACIewAAAIh\n7AAAAiHsAAACIewAAAIh7ACAwFVXVxcVFVVXV6d7kFon7ACAkFVXV/fr169jx479+vULvu2E\nHQAQsuXLl7/88stRFL388svLly9P9zi1S9gBACGrrKzc6c9BEnYAAIEQdgAAgRB2AACBEHYA\nAIEQdgAAgRB2AACBEHYAAIEQdgAAgRB2AACBEHYAAIEQdgAAgRB2AACBEHYAAIEQdgAAgRB2\nAACBEHYAAIEQdgAAgRB2AACBEHYAAIEQdgAAgRB2AACBEHYAAIEQdgAAgRB2AACBEHYAAIEQ\ndgAAgRB2AACBEHYAAIEQdgAAgRB2AACBEHYAAIEQdgAAgRB2AACBEHYAAIEQdgAAgRB2AACB\nEHYAAIEQdgAAgRB2AACBEHYAAIEQdgAAgRB2AACBEHYAAIEQdgAAgRB2AACBEHYAAIEQdgAA\ngRB2AACBEHYAAIEQdgAAgchO9wDf0oZVK5YuXbZm/aaSLWXZ9Rs0atayS9duB7ZqnO65AADS\nJmZhV1NV/ORdN97z0LR5S9Z8/WzLrr3PGTXmujFnN87OSP1sAADpFaewq6r4ZGTPw6cuXJeV\n07RXv0GHdevUqnnj3NzsreXlG9eu/mjZonlzX7/zymGPTXt+wauPta7nXWYAoG6JU9i9esWA\nqQvXHXfJ3dNvv6htg51MXl2xbvqEi0eMn3bKpaMW3d8n5QMCAKRTnMLu2qnL8lv9ZO69o3d1\nQWa9ZsOvm7G54OUxM8ZF97+SzGtWVVUVFBSUlZUluKaoqCiKourq6t2cFwAgpeIUdu+WVOZ3\nHfiNl/U4oUXlW4uSfM3Zs2cPGjQomSv/9re/Jfmau5KTk7PTnwGA2lOn/v7GKewGN8ubseT2\n1RUDWib4/Fx16cNPFtVvclqSr9m3b9+ZM2cmvmP3wgsvTJky5Zxzztmtab+uc+fOJ5544ssv\nv3ziiSd27tz5O74aAJCMOvX3N05hN3ZC/ynnP9O999Bf3XbNmScf2SDrq4++1pQvfqXgzht+\n+lDRptMnjk/yNbOysgYO/Ia7gJ9++umUKVO+e+NnZmb+5S9/WblyZbt27TIzPdsBAKlQp/7+\nxinsupz31K/fPPXCSc+MGPB0Vr1GB3bp1Hq/xrm5OVUV5cVrV324rHB92daMjIy+F9038+Ju\n6R525zIzMzt06JDuKQCgbqk7f3/jFHZRlDlq4qzTRvzuvkemF8x+bcn7by9bVLPtREZmbttO\nh5zSt/+wUaMH92yT3ikBANIiXmEXRVHUpteQW3sNuTWKaraWbtz4eUlpRb28fRo2bpLnS4kB\ngLotfmG3XUZ2XpPmeU3SPQYAwF4i8I8QAgDUHcIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDC\nDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDCDgAgEMIOACAQwg4AIBDZ6R4gNpYuXVq/\nfv3v+CJbt2595JFH2rdvn5kpqQEgRaqrqz/66KORI0dmZ++B8lm6dOl3f5FaIuy+WU5OThRF\nF1xwQboHAQC+vfvvv38Pvtq2PNjbCLtvNnz48K1bt5aWln73l1qwYMH06dOPP/74du3affdX\nAwCSsXLlyrlz5w4bNuzwww/fIy+Yl5c3fPjwPfJSe1ZGTU1NumeoQ5566qmhQ4c++eSTZ511\nVrpnAYC6ou78/fVJLwCAQAg7AIBACDsAgEAIOwCAQAg7AIBACDsAgEAIOwCAQAg7AIBACDsA\ngEAIu5TKy8vb/l8AIDXqzt9fK8VSqqqq6s9//vNJJ52UlZWV7lkAoK6oO39/hR0AQCC8FQsA\nEAhhBwAQCGEHABAIYQcAEAhhBwAQCGEHABAIYQcAEAhhBwAQCGEHABAIYQcAEAhhBwAQCGEH\nABAIYQcAEAhhBwAQCGEHABAIYQcAEAhhl0rVf3pgbJ/DOjbMrd/igIPPvfLuTyuq0z0SANQV\nW/7+2BFHHLGgpDLdg9QiYZc6T13S+9QLb31rXZMzzj7r+/tvnnrHZYf2GLmpqibdcwFAnfDy\n9be98847W6pD/ssr7FLk848mD5v01r4HnrdsxVszHpv6x7dWTv3JIevfe2zwvYvTPRoABK7k\n74Uz7rpk0ANL0z1IrcuoqQm5W/cefxra6dSnPrx8wdo7Dmu27UhVeVGLhp1KGw3e8tkz6Z0N\nAALWt32zOSvXb/913qbyYxrWS+M8tUrYpciZ++0zc2PuxrL1DbMyth/8RecmVxdufOPzip75\nOWmcDQAC9ug9v1pXWRVF0RsTrn/ysy1hh112ugeoE2qqt7y4vqx+88Ffrrooinr1aBYVbnx2\nbamwA4Bacv7oy7b98MgDtz752Zb0DlPbfMYuFarKV5ZX1+Ts032H4/sevG8URcu2hPx4DgCQ\nMsIuFaor10ZRlJm17w7Hc/JzoijaUizsAIA9QNilQmZ2kyiKqqs+3+F45ebKKIpyG3pDHADY\nA4RdKmTV71A/M2Nr6ZIdjn++5PMoijo38AE7AGAPEHapkJHZoH+T+mXr/1D21U0TC+avi6Lo\nX5vnpWcsACAswi5FLj6xZVXlZ7/4cOP2I9WVayes3JTXfEjvcB+6BgBSSdilSO87rsrIyJj4\nH7/YftNu7i/+9ZPyqqPH3ZzWuQCAcPjYfoo07PD/pl94/3/8z22djl1y3qmHrl/8lwee/muT\nbuc/e/HB6R4NAAiEO3apc/bk+b+/4/K26968+7bbf/vXVWdfcvu77zzUJDvjm/9PAIAkWCkG\nABAId+wAAAIh7AAAAiHsAAACIewAAAIh7AAAAiHsAAACIewAAAIh7AAAAiHsAAACIewAAAIh\n7AAAAiHsAAACIewAAAIh7AAAAiHsAAACIewAAAIh7AAAAiHsAAACIewAAAIh7AAAAiHsAAAC\nIewAAAIh7AAAAiHsAAACIewAAAIh7AAAAiHsAAACIewAAAIh7AAAAiHsAAACIewAAAIh7AAA\nAiHsAAACIewAAAIh7AAAAiHsAAACIewAAAIh7AAAAiHsAAACIewAAAIh7AAAAiHsAAACIewA\nAAIh7AAAAiHsAAACIewAAAIh7AAAAiHsAAACIewAAAIh7AAAAiHsAAACIewAAAIh7AAAAiHs\nAAACIewAAAIh7AAAAiHsAAACIewAAAIh7AAAAiHsAAACIewAAAIh7AAAAiHsAAACIewAAAIh\n7AAAAiHsAAACIewAAAIh7AAAAiHsAAACIewAAAIh7AAAAiHsAAACIewAAAIh7AAAAiHsAAAC\nIewAAALx/wEfgUehkwHmXgAAAABJRU5ErkJggg=="
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "plot(no_gender)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "id": "68e17b07",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-22T22:47:21.922289Z",
     "iopub.status.busy": "2022-01-22T22:47:21.920901Z",
     "iopub.status.idle": "2022-01-22T22:47:21.958566Z",
     "shell.execute_reply": "2022-01-22T22:47:21.957527Z"
    },
    "papermill": {
     "duration": 0.088565,
     "end_time": "2022-01-22T22:47:21.958695",
     "exception": false,
     "start_time": "2022-01-22T22:47:21.870130",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\n",
       "    0     1 \n",
       " 7946 22054 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "table(sns_data$female, useNA=\"ifany\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 13,
   "id": "ce741c7f",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-22T22:47:22.057996Z",
     "iopub.status.busy": "2022-01-22T22:47:22.056422Z",
     "iopub.status.idle": "2022-01-22T22:47:22.072875Z",
     "shell.execute_reply": "2022-01-22T22:47:22.071576Z"
    },
    "papermill": {
     "duration": 0.067131,
     "end_time": "2022-01-22T22:47:22.073023",
     "exception": false,
     "start_time": "2022-01-22T22:47:22.005892",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "#determining the average age for each graduating year\n",
    "avg_age<- ave(sns_data$age, sns_data$gradyear, FUN = function(x) mean(x, na.rm = TRUE))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 14,
   "id": "8b2dcba0",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-22T22:47:22.172088Z",
     "iopub.status.busy": "2022-01-22T22:47:22.171226Z",
     "iopub.status.idle": "2022-01-22T22:47:22.182698Z",
     "shell.execute_reply": "2022-01-22T22:47:22.181523Z"
    },
    "papermill": {
     "duration": 0.062201,
     "end_time": "2022-01-22T22:47:22.182854",
     "exception": false,
     "start_time": "2022-01-22T22:47:22.120653",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "#replacing the age missing values with the average age of each graduating year\n",
    "replace_missing_value<-ifelse(is.na(sns_data$age),avg_age, sns_data$age)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 15,
   "id": "7892e2e0",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-22T22:47:22.287416Z",
     "iopub.status.busy": "2022-01-22T22:47:22.281268Z",
     "iopub.status.idle": "2022-01-22T22:47:22.301616Z",
     "shell.execute_reply": "2022-01-22T22:47:22.300262Z"
    },
    "papermill": {
     "duration": 0.071059,
     "end_time": "2022-01-22T22:47:22.301752",
     "exception": false,
     "start_time": "2022-01-22T22:47:22.230693",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. \n",
       "  13.03   16.28   17.24   17.24   18.21   20.00 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "summary(replace_missing_value)"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.0.5"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 6.452709,
   "end_time": "2022-01-22T22:47:22.461113",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2022-01-22T22:47:16.008404",
   "version": "2.3.3"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
