# YGB

![WhatsApp Image 2023-05-08 at 9 45 12 PM (1)](https://github.com/kaaryaal/ygb/assets/132779238/8ef8ec57-3c77-4a64-ba15-02f2b8b4ead7)
![WhatsApp Image 2023-05-08 at 9 45 12 PM](https://github.com/kaaryaal/ygb/assets/132779238/bbcaf16b-c18c-42c7-b26e-f2faa822c359)
![WhatsApp Image 2023-05-08 at 9 45 13 PM (1)](https://github.com/kaaryaal/ygb/assets/132779238/3d3479ed-02dc-4cd4-808b-27c678f344ae)
![WhatsApp Image 2023-05-08 at 9 45 13 PM](https://github.com/kaaryaal/ygb/assets/132779238/18eb40d0-ebf4-45cf-89fd-447662c9ce03)
![WhatsApp Image 2023-05-08 at 9 46 55 PM](https://github.com/kaaryaal/ygb/assets/132779238/f8d4448a-59ac-45a0-9273-9a08dee45e24)



YGB is a mobile application designed for fitness programs.
In this app, with each program there are several excercises attached order by week days (from monday - saturday). There are some excercises which are free and some are paid. To unlock all the paid excercise, you hav to purchase monthly subcription of $15.

## App Architecture:

The app is using MVVM, one of the most favourite in the industry.

## Features:

In this application we have used the following features

- Login, Signup and forgot (used with firebase authentication)
- Programs (Each program has many excercises)
- Excercises (Each excercise is ascociated with wee day and a program)
- Excercise can be paid or free (managed by admin)
- To unlock the paid excercise, you have to buy $15 subscription per month
- For payment, the application is using Stripe

## Configuration:

As the project is using Google Firebase services, so you have to add a firebase project to this flutter application.
With this, the app is using stripe as well. There are two keys required (PUBLIC_KEY & SECRET_KEY). Create a .env file in the root folder and add the Stripe keys variables in the environment.

### Apk Download link
link: https://drive.google.com/file/d/1QZQHAJDQWXYmI47LxgKBEmOvyY8uPMGS/view?usp=share_link
