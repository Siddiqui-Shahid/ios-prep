// MaxProfit.swift — Best Time to Buy and Sell Stock
import Foundation

enum MaxProfit {
    /// One buy + one sell. O(n) / O(1)
    static func maxProfit(_ prices: [Int]) -> Int {
        guard !prices.isEmpty else { return 0 }
        var minPrice = prices[0]
        var best = 0
        for price in prices {
            minPrice = min(minPrice, price)
            best = max(best, price - minPrice)
        }
        return best
    }
}
