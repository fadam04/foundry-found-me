# FundMe - Ethereum Smart Contract 💰  

FundMe is a smart contract that allows users to send ETH to support a project. It integrates **Chainlink Price Feeds** to ensure that contributions meet a minimum USD value. The contract is built with **Solidity** and tested using **Foundry**.

---

## 🚀 Features  

✅ **ETH Funding** – Users can contribute ETH with a minimum of **5 USD**.  
✅ **Chainlink Price Feed** – Retrieves real-time ETH/USD exchange rates.  
✅ **Secure Withdrawals** – Only the contract owner can withdraw funds.  
✅ **Optimized Gas Usage** – Implements `cheaperWithdraw()` for efficiency.  
✅ **Fallback & Receive Functions** – Accepts direct ETH transactions.  

---

## 📥 Installation & Setup  

### 1️⃣ Clone the Repository  

git clone https://github.com/YourUsername/FundMe.git
cd FundMe
2️⃣ Install Dependencies
Ensure Foundry is installed. If not, install it with:


curl -L https://foundry.paradigm.xyz | bash
foundryup
Then, install the project dependencies:


forge install
3️⃣ Compile the Smart Contract

forge build
4️⃣ Run Tests
This project includes unit tests to ensure functionality. Run all tests with:


forge test --gas-report
🚀 Deployment
To deploy the contract using Foundry, run:


forge script script/DeployFundMe.s.sol --rpc-url <NETWORK_RPC_URL> --private-key <YOUR_PRIVATE_KEY> --broadcast
Replace <NETWORK_RPC_URL> and <YOUR_PRIVATE_KEY> with your actual values.

🛠 Testing
The FundMeTest.sol file includes various tests to verify contract behavior:

🔹 Checking Chainlink Price Feed – Ensures the correct ETH/USD price version.
🔹 Funding Tests – Verifies the ability to fund and track balances.
🔹 Owner-Only Withdrawals – Ensures that only the contract owner can withdraw.
🔹 Optimized Withdrawals – Validates the cheaperWithdraw() function for gas efficiency.

To execute tests, run:


forge test --gas-report
🔗 Technologies Used
Solidity 0.8.18
Foundry (Forge, Cast, Anvil)
Chainlink Price Feeds
Ethereum Smart Contracts
📜 License
This project is licensed under the MIT License.

💡 Contributions & Issues
Feel free to fork this project, submit issues, or contribute improvements! 🚀


This README is **optimized for GitHub**, featuring:  
- **Proper headings and icons** for a clean structure  
- **Code blocks** for easy command execution  
- **Bold and emoji highlights** for readability  

Let me know if you need any changes! 🚀










