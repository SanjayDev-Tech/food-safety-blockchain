;; FoodSafety Verification Contract
;; Farm-to-table tracking system ensuring food safety and organic certification compliance

;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-unauthorized (err u101))
(define-constant err-product-not-found (err u102))
(define-constant err-invalid-certification (err u103))
(define-constant err-already-exists (err u104))
(define-constant err-invalid-amount (err u105))

;; Data structures
(define-map products
  { product-id: (string-ascii 32) }
  {
    farmer: principal,
    product-name: (string-ascii 64),
    origin-farm: (string-ascii 128),
    harvest-date: uint,
    organic-certified: bool,
    safety-score: uint,
    certification-body: (string-ascii 64),
    current-location: (string-ascii 128),
    verification-timestamp: uint
  }
)

(define-map certifications
  { cert-id: (string-ascii 32) }
  {
    issuer: principal,
    product-id: (string-ascii 32),
    certification-type: (string-ascii 32),
    issue-date: uint,
    expiry-date: uint,
    is-valid: bool,
    verification-hash: (string-ascii 64)
  }
)

;; Product counter for unique IDs
(define-data-var product-counter uint u0)
(define-data-var cert-counter uint u0)

;; Function 1: Register Product with Safety Verification
(define-public (register-product 
    (product-id (string-ascii 32))
    (product-name (string-ascii 64))
    (origin-farm (string-ascii 128))
    (harvest-date uint)
    (organic-certified bool)
    (safety-score uint)
    (certification-body (string-ascii 64))
    (current-location (string-ascii 128)))
  (begin
    ;; Input validation
    (asserts! (> (len product-id) u0) err-invalid-amount)
    (asserts! (> (len product-name) u0) err-invalid-amount)
    (asserts! (> (len origin-farm) u0) err-invalid-amount)
    (asserts! (> harvest-date u0) err-invalid-amount)
    (asserts! (> (len certification-body) u0) err-invalid-amount)
    (asserts! (> (len current-location) u0) err-invalid-amount)
    
    ;; Check if product already exists
    (asserts! (is-none (map-get? products { product-id: product-id })) err-already-exists)
    
    ;; Validate safety score (0-100 scale)
    (asserts! (<= safety-score u100) err-invalid-certification)
    
    ;; Register the product
    (map-set products
      { product-id: product-id }
      {
        farmer: tx-sender,
        product-name: product-name,
        origin-farm: origin-farm,
        harvest-date: harvest-date,
        organic-certified: organic-certified,
        safety-score: safety-score,
        certification-body: certification-body,
        current-location: current-location,
        verification-timestamp: stacks-block-height
      }
    )
    
    ;; Increment product counter
    (var-set product-counter (+ (var-get product-counter) u1))
    
    ;; Print verification event
    (print {
      event: "product-registered",
      product-id: product-id,
      farmer: tx-sender,
      organic-certified: organic-certified,
      safety-score: safety-score,
      timestamp: stacks-block-height
    })
    
    (ok true)
  )
)

;; Function 2: Verify Certification and Update Product Status
(define-public (verify-certification
    (product-id (string-ascii 32))
    (cert-id (string-ascii 32))
    (certification-type (string-ascii 32))
    (expiry-date uint)
    (verification-hash (string-ascii 64)))
  (let
    (
      (product-data (unwrap! (map-get? products { product-id: product-id }) err-product-not-found))
    )
    
    ;; Input validation
    (asserts! (> (len product-id) u0) err-invalid-amount)
    (asserts! (> (len cert-id) u0) err-invalid-amount)
    (asserts! (> (len certification-type) u0) err-invalid-amount)
    (asserts! (> expiry-date u0) err-invalid-amount)
    (asserts! (> (len verification-hash) u0) err-invalid-amount)
    
    ;; Only the farmer or contract owner can verify certifications
    (asserts! (or 
      (is-eq tx-sender (get farmer product-data))
      (is-eq tx-sender contract-owner)) 
      err-unauthorized)
    
    ;; Ensure expiry date is in the future
    (asserts! (> expiry-date stacks-block-height) err-invalid-certification)
    
    ;; Check if certification already exists
    (asserts! (is-none (map-get? certifications { cert-id: cert-id })) err-already-exists)
    
    ;; Add certification record
    (map-set certifications
      { cert-id: cert-id }
      {
        issuer: tx-sender,
        product-id: product-id,
        certification-type: certification-type,
        issue-date: stacks-block-height,
        expiry-date: expiry-date,
        is-valid: true,
        verification-hash: verification-hash
      }
    )
    
    ;; Update product with enhanced safety score for certified products
    (map-set products
      { product-id: product-id }
      (merge product-data {
        safety-score: (if (get organic-certified product-data) u95 u85),
        verification-timestamp: stacks-block-height
      })
    )
    
    ;; Increment certification counter
    (var-set cert-counter (+ (var-get cert-counter) u1))
    
    ;; Print certification event
    (print {
      event: "certification-verified",
      product-id: product-id,
      cert-id: cert-id,
      certification-type: certification-type,
      verifier: tx-sender,
      timestamp: stacks-block-height
    })
    
    (ok true)
  )
)

;; Read-only functions for data retrieval

;; Get product information
(define-read-only (get-product (product-id (string-ascii 32)))
  (map-get? products { product-id: product-id }))

;; Get certification information
(define-read-only (get-certification (cert-id (string-ascii 32)))
  (map-get? certifications { cert-id: cert-id }))

;; Get total registered products
(define-read-only (get-product-count)
  (var-get product-counter))

;; Get total certifications issued
(define-read-only (get-certification-count)
  (var-get cert-counter))

;; Verify if a product meets safety standards (safety score >= 80)
(define-read-only (meets-safety-standards (product-id (string-ascii 32)))
  (match (map-get? products { product-id: product-id })
    product-data (>= (get safety-score product-data) u80)
    false))

;; Check if product is organically certified and has valid certifications
(define-read-only (is-organic-verified (product-id (string-ascii 32)))
  (match (map-get? products { product-id: product-id })
    product-data (and 
      (get organic-certified product-data)
      (>= (get safety-score product-data) u90))
    false))