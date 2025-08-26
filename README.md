# 🥬 FoodSafety Verification - Blockchain Food Traceability

A decentralized farm-to-table tracking system built on Stacks blockchain that ensures food safety compliance and organic certification verification throughout the entire supply chain.

## 📋 Project Description

FoodSafety Verification is a comprehensive blockchain solution that brings transparency and trust to the food industry. Our platform enables farmers to register their products with detailed safety information, while certification bodies can verify organic certifications and safety standards. Each product is tracked with immutable records from farm to table, ensuring consumers can trust the authenticity and safety of their food.

## 🛠️ Tech Stack Used

- **Blockchain Platform**: Stacks Blockchain
- **Smart Contract Language**: Clarity
- **Development Framework**: Clarinet
- **Version Control**: Git & GitHub
- **Testing**: Clarinet Test Framework
- **Network**: Stacks Testnet/Mainnet

### Additional Dependencies:
- Node.js (v16 or higher)
- Clarinet CLI
- Stacks CLI (for deployment)

## ⚙️ Setup Instructions

### Prerequisites
1. Install Node.js (v16+): https://nodejs.org/
2. Install Clarinet: https://github.com/hirosystems/clarinet
```bash
# Install Clarinet
curl -L https://github.com/hirosystems/clarinet/releases/latest/download/clarinet-linux-x64.tar.gz | tar xz
sudo mv clarinet /usr/local/bin
```

### Local Development Setup
```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/food-safety-blockchain.git
cd food-safety-blockchain

# Verify Clarinet installation
clarinet --version

# Check contract syntax
clarinet check

# Run tests
clarinet test

# Start local development environment
clarinet integrate
```



## 🔗 Smart Contract Address

### Testnet Deployment
- **Contract Address**: ST3W8DV984FG6T2JKHJ158CR9JTCY07N0J3GJCG75.FoodSafetyVerification
- **Network**: Stacks Testnet
- **Deployer**: ST3W8DV984FG6T2JKHJ158CR9JTCY07N0J3GJCG75
- **Transaction ID**: 0xabfa19ab450b67e2f3a84fca7a0b129b4c1bc34f1974774067dec7abb9db33d3



**Deployment Commands:**
```bash
# Deploy to testnet
clarinet deployment generate --testnet --low-cost
clarinet deployment apply --testnet




## 🚀 How to Use the Project

### For Farmers (Product Registration)

1. **Register Your Product**:
```clarity
(contract-call? .FoodSafetyVerification register-product 
  "PROD001"                    ;; product-id
  "Organic Tomatoes"           ;; product-name  
  "Green Valley Farm, CA"      ;; origin-farm
  u1703980800                  ;; harvest-date (timestamp)
  true                         ;; organic-certified
  u92                          ;; safety-score (0-100)
  "USDA Organic"              ;; certification-body
  "Farm Storage Facility")     ;; current-location
```

2. **Check Registration Status**:
```clarity
(contract-call? .FoodSafetyVerification get-product "PROD001")
```

### For Certification Bodies (Verification)

1. **Verify Product Certification**:
```clarity
(contract-call? .FoodSafetyVerification verify-certification
  "PROD001"                    ;; product-id
  "CERT001"                    ;; cert-id
  "Organic"                    ;; certification-type
  u1735516800                  ;; expiry-date
  "abc123def456")              ;; verification-hash
```

### For Consumers (Product Verification)

1. **Check Product Safety**:
```clarity
(contract-call? .FoodSafetyVerification meets-safety-standards "PROD001")
```

2. **Verify Organic Certification**:
```clarity
(contract-call? .FoodSafetyVerification is-organic-verified "PROD001")
```

3. **Get Complete Product Information**:
```clarity
(contract-call? .FoodSafetyVerification get-product "PROD001")
```

### Key Features Available:
- ✅ **Product Registration**: Complete farm-to-table product tracking
- ✅ **Safety Scoring**: 0-100 scale safety assessment  
- ✅ **Organic Certification**: Verified organic status tracking
- ✅ **Certification Management**: Issue and verify certificates
- ✅ **Audit Trail**: Immutable tracking of all transactions
- ✅ **Multi-stakeholder**: Support for farmers, certifiers, and consumers



## 📸 Screenshots & Demo


<img width="1920" height="1080" alt="Screenshot (118)" src="https://github.com/user-attachments/assets/431a1548-20fd-4032-b94e-028084c0ba69" />


### Contract Deployment
```bash
# Example successful deployment output
✅ FoodSafetyVerification deployed successfully
📍 Contract Address: SP1234...ABCD.FoodSafetyVerification
⛽ Gas Used: 12,450 STX
🎯 Transaction: 0xabc123...def456
```

### Product Registration Flow
1. **Step 1**: Farmer registers product with safety details
2. **Step 2**: System validates input and creates immutable record  
3. **Step 3**: Product receives unique ID and safety score
4. **Step 4**: Certification body can verify and enhance scoring

### Sample Transaction Results
```json
{
  "event": "product-registered",
  "product-id": "TOMATO-001",
  "farmer": "SP1A1JQ1M...",
  "organic-certified": true,
  "safety-score": 95,
  "timestamp": 123456
}
```

## 🎯 Project Vision

Transform the global food industry by creating a transparent, trustworthy, and decentralized food safety ecosystem that protects consumers while empowering farmers and promoting sustainable agriculture practices.

## 🔮 Future Scope

### Phase 1 (Next 3-6 months)
- 📱 Mobile app for consumers
- 🌐 Web dashboard for farmers
- 🔗 Supply chain integration
- 📊 Analytics dashboard

### Phase 2 (6-12 months)
- 🤖 IoT sensor integration
- 🎯 NFT certificates for premium products
- 🔄 Cross-chain compatibility
- 🧠 AI-powered quality prediction

### Phase 3 (1+ years)
- 🌍 Global marketplace
- 🌱 Carbon footprint tracking
- 🏛️ Government system integration
- 🔍 Advanced fraud detection

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.



---

