# README
Versions required:

* Ruby version: 3.0.6

* Rails version: 7.0.6

=> Flow of the application
1. First create the user with API= POST: http://localhost:3000/api/v1/users
2. After then you can sign in with your credentials with API= POST: http://localhost:3000/api/v1/users/login
3. To deposit the amount: API= POST: http://localhost:3000/api/v1/bank_accounts/:id/deposit
4. To withdraw the amount: API= POST: http://localhost:3000/api/v1/bank_accounts/:id/withdraw
5. To see transaction history on the ROR view= GET: http://localhost:3000/transaction_history (Where you have to sign-in first)
