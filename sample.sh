#!/bin/bash



echo "Creating employee CSV file: employee_data.csv..."



# CSV header

echo "ID,Name,Age,City,Occupation,Salary,HireDate,Department,Rating,Notes" > employee_data.csv



# Data sources

first_names=("John" "Mary" "James" "Patricia" "Robert" "Jennifer" "Michael" "Linda" "William" "Elizabeth" "David" "Barbara" "Richard" "Susan" "Joseph" "Jessica" "Thomas" "Sarah" "Charles" "Karen")

last_names=("Smith" "Johnson" "Williams" "Brown" "Jones" "Miller" "Davis" "Garcia" "Rodriguez" "Wilson" "Martinez" "Anderson" "Taylor" "Thomas" "Hernandez" "Moore" "Martin" "Jackson" "Thompson" "White")

cities=("New York" "Los Angeles" "Chicago" "Houston" "Phoenix" "Philadelphia" "San Antonio" "San Diego" "Dallas" "San Jose" "Austin" "Jacksonville" "Fort Worth" "Columbus" "San Francisco" "Charlotte" "Indianapolis" "Seattle" "Denver" "Boston")

jobs=("Software Engineer" "Product Manager" "Data Analyst" "UI Designer" "Marketing Specialist" "HR Manager" "Accountant" "Sales Representative" "Customer Manager" "DevOps Engineer" "QA Engineer" "R&D Director" "Project Manager" "Administrative Assistant" "Director" "CEO" "CTO" "CFO" "Instructor" "Consultant")

departments=("Engineering" "Product" "Design" "Marketing" "Sales" "Human Resources" "Finance" "Administration" "Legal" "Customer Support")

notes=("Excellent performance" "Needs improvement" "High potential" "Ready for promotion" "New hire" "Experienced" "Highly innovative" "Great team player" "Strong communicator" "Technical expert")



# Generate 1000 data rows

for ((i=1; i<=1000; i++)); do

    id=$i

    first_name=${first_names[$((RANDOM % ${#first_names[@]}))]}

    last_name=${last_names[$((RANDOM % ${#last_names[@]}))]}

    fullname="$first_name $last_name"

    age=$((20 + RANDOM % 40))

    city=${cities[$((RANDOM % ${#cities[@]}))]}

    job=${jobs[$((RANDOM % ${#jobs[@]}))]}

    salary=$((50000 + RANDOM % 150000))

    hire_date=$(date -d "-$((RANDOM % 1825)) days" "+%Y-%m-%d")

    department=${departments[$((RANDOM % ${#departments[@]}))]}

    rating=$(awk -v min=1 -v max=5 'BEGIN {srand(); print min+rand()*(max-min)}' | xargs printf "%.1f")

    note=${notes[$((RANDOM % ${#notes[@]}))]}

    echo "$id,$fullname,$age,$city,$job,$salary,$hire_date,$department,$rating,$note" >> employee_data.csv

done



echo "Employee CSV file created successfully!"

