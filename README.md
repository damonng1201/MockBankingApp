# MockBankingApp

Assumptions:
1. All the user data such as username, balance will be stored in CoreData UserEntity
2. All the payment transactions will be stored in CoreData TransactionEntity
3. All the debts occurred during pay transactions will be stored in CoreData DebtEntity
4. When user entered existing username the app will bring user to dashboard screen to allow user perform top up or make payment
5. if user entered non exist username the app will auto create a new user based on the username entered, initial balance will be zero. After user creation will bring user to dashboard
6. After login, dashboard will showed greeting to the logged in user, account balance, last transaction and existing debts
7. When user perform top up, everytime the app will fetch if there is any outstanding debts and make payment to the creditors to clear the debts as soon as possible. After deducted debts the remaining top up amount will be credited to user's balance
8. In transfer to screen, all the users besides logged in user will be displayed in the list of payees
9. When user perform payment, if there is any outstanding debts to the payee, pay amount will deduct outstanding debt amount and update in CoreData DebtEntity, the remaining balance of the pay amount will be treated as a payment transaction to the payee and stored in CoreData TransactionEntity.
10. When user perform payment, if the payee is having outstanding debts to the user, pay amount will deduct he payee's debts to the user and update in CoreData DebtEntity.
