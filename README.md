![Md. Asraful Alom]()
# What is PostgreSQL?
PostgreSQL হলো একটি ওপেন সোর্স, অবজেক্ট-রিলেশনাল ডেটাবেজ ম্যানেজমেন্ট সিস্টেম (RDBMS)। এটি ACID কমপ্লায়েন্সড এবং বড় আকারের ডেটা সংরক্ষণ, প্রসেস ও ম্যানেজ করতে সক্ষম। 

## What is the purpose of a database schema in PostgreSQL?
একটি ডাটাবেস স্কিমাকে একটি ডাটাবেসের "ব্লুপ্রিন্ট" হিসেবে বিবেচনা করা হয় যা বর্ণনা করে যে ডেটা কীভাবে অন্যান্য টেবিল বা অন্যান্য ডেটা মডেলের সাথে সম্পর্কিত হতে পারে|ডেটা স্টোরেজের জন্য নিয়ম, সীমাবদ্ধতা এবং বিন্যাস সংজ্ঞায়িত করে।


## Explain the Primary Key and Foreign Key concepts in PostgreSQL.

Primary Key: যে ফিল্ডের সাহায্যে কোন রেকর্ডকে ইউনিক বা অদ্বিতীয়ভাবে সনাক্ত করা যায়, তাকে Primary Key বলে। এই টেবিলের Student – ID ডুপ্লিকেট হওয়ার সম্ভাবনা নেই। তাই এটি Primary Key, একটি টেবিলে একটির বেশি Primary Key থাকে না। Primary Key তে একাধিক ভ্যালু বা নাল ভ্যালু (Null value) থাকতে পারে না।
CREATE TABLE student(s_id SERIAL PRIMARY KEY, name VARCHAR(100);

Foreign Key: কোনো একটি টেবিলের প্রাইমারি কী যদি অন্য কোন টেবিলের সাধারণ কী হিসেবে ব্যবহার করা হয় তাকে Foreign Key বলে। এখানে Student – ID প্রাইমারি কী অন্য টেবিলে ব্যবহৃত হয়েছে। তাই Student ID এখানে Foreign Key একটি টেবিলের Foreign Key কে অবশ্যই রেফারেন্স টেবিলের প্রাইমারি কী হতে হবে।
CREATE TABLE marks(suject_id SERIAL PRIMARY KEY, subject_name VARCHAR(100), marks INT, s_id INTEGER REFERENCES student (s_id) ON DELETE CASCADE);


## What is the difference between the VARCHAR and CHAR data types?
Char এবং Varchar হল দুটি ডেটা টাইপ যা SQL সার্ভারে ব্যাপকভাবে ব্যবহৃত হয়। প্রধান পার্থক্য হল Char হলো স্ট্যাটিক এবং Varchar হলো ডাইনামিক । উদহারণ স্বরূপ আমরা Char(50)
এবং  Varchar(50) তে  10  সংখ্যার একটি স্ট্রিং রাখি তাহলে Char সম্পূর্ণ যায়গাটায় নিবে অন্যদিকে Varchar নিবে স্ট্রিং এর সমান যায়গা । 


## Explain the purpose of the WHERE clause in a SELECT statement.

WHERE ক্লজ SQL-এর একটি গুরুত্বপূর্ণ অংশ যা নির্দিষ্ট শর্তের ভিত্তিতে ডেটা ফিল্টার করার জন্য ব্যবহৃত হয়। এটি একটি বা একাধিক শর্ত ব্যবহার করে ডেটা সিলেক্ট, আপডেট, ডিলিট বা ইনসার্ট করতে সাহায্য করে।

```sh 
SELECT common_name
FROM species
WHERE
    species_id NOT IN (
        SELECT species_id
        FROM sightings
    );
```
