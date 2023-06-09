# YGB
## App Screenshots:
![YGB app (1)](https://github.com/kaaryaal/ygb/assets/132779238/f53af395-035c-46cb-995b-4228be35056a)

## Admin Panel Screenshots:
![YGB app admin panel](https://github.com/kaaryaal/ygb/assets/132779238/4dab7f82-9ad0-475a-9bf9-8fb17e0aea54)

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
