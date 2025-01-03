# NFT MarketPlace on ICP Blockchain

## Project Overview

This project is a decentralized NFT marketplace built on the Internet Computer (ICP) blockchain using Dfinity's `dfx`. It is inspired by OpenSea and allows users to buy, sell, and discover NFTs. The platform also introduces a custom cryptocurrency that can be used to trade NFTs within the ecosystem.

The project is part of my learning journey in web development from Angela Yu's Udemy course. It is currently for local testing and has not been deployed yet.

## Features

- **NFT Discovery** – Browse and discover NFTs available for sale or trade.
- **Buy and Sell NFTs** – List your NFTs for sale or purchase NFTs from other users.
- **Custom Cryptocurrency Integration** – Exchange NFTs using a proprietary cryptocurrency created as a separate project.
- **Decentralized Infrastructure** – Built on the ICP blockchain for a secure and distributed environment.

## Tech Stack

- **Frontend:** HTML, CSS, JavaScript, React
- **Backend:** Dfinity (dfx) for blockchain and smart contract deployment
- **Blockchain:** Internet Computer (ICP)
- **Cryptocurrency:** Custom crypto token (Independent Project)

## Installation and Setup

### Prerequisites

- Install [Dfinity SDK (dfx)](https://internetcomputer.org/docs/current/developer-docs/setup/local-setup/)
- Node.js (for frontend development, if applicable)
- npm or yarn

### Running the Project Locally

```bash
# Clone the repository
git clone <repository-url>
cd nft-marketplace-icp

# Start the local Dfinity environment
dfx start

# Deploy canisters (smart contracts)
dfx deploy

# Run the frontend (if applicable)
npm install
npm start
```

## Usage

- Visit `http://localhost:8000` after deployment to interact with the marketplace.
- Mint NFTs through the Dfinity interface.
- Use the custom cryptocurrency to buy or sell NFTs.

## Roadmap

- **Deployment to ICP Mainnet**
- **Smart Contract Enhancements** for better NFT management.
- **Improved UI/UX** with React and Tailwind CSS.
- **User Authentication** with Internet Identity.
- **Wallet Integration** for easier transactions.

## Acknowledgements

This project is inspired by Angela Yu’s Web Development Bootcamp on Udemy and serves as a foundational step in my Web3 development journey.

## License

MIT License

---

Feel free to contribute, suggest features, or fork this project for your own learning journey!

