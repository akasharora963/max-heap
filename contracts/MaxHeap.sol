// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.19;

contract MaxHeap {
    struct Orderbook {
        uint256 price;
        uint256 quantity;
    }
    
    Orderbook[] private heap;

    constructor(){}

    function sortPrice() external {
        uint256 heapLength = heap.length;
        for (uint256 i = heapLength/ 2; i > 0;) {
            maxHeapify(i);
            unchecked {
                --i;
            }
        }
    }

    function getHeap() external view returns(Orderbook[] memory) {
        return heap;
    }

    function maxHeapify(uint256 i) private {
        uint256 left = 2 * i;
        uint256 right = 2 * i + 1;
        uint256 largest = i;

        if (left <= heap.length && heap[left - 1].price > heap[largest - 1].price) {
            largest = left;
        }
        if (right <= heap.length && heap[right - 1].price > heap[largest - 1].price) {
            largest = right;
        }
        if (largest != i) {
            Orderbook memory temp = heap[i - 1];
            heap[i - 1] = heap[largest - 1];
            heap[largest - 1] = temp;
            maxHeapify(largest);
        }
    }

    function findMax() external view returns (Orderbook memory) {
        require(heap.length > 0, "Heap is empty");
        return heap[0];
    }

    function findMin() external view returns (Orderbook memory) {
        uint256 heapLength = heap.length;
        require(heapLength > 0, "Heap is empty");
        Orderbook memory minOrder = heap[0];
        for (uint256 i = 1; i < heapLength;) {
            if (heap[i].price < minOrder.price) {
                minOrder = heap[i];
            }
            unchecked {
                ++i;
            }
        }
        return minOrder;
    }

    function popMax() external returns (Orderbook memory) {
        uint256 heapLength = heap.length;
        require(heapLength > 0, "Heap is empty");
        Orderbook memory max = heap[0];
        heap[0] = heap[heapLength- 1];
        heap.pop();
        if (heapLength > 0) {
            maxHeapify(1);
        }
        return max;
    }

    function insert(uint256 price, uint256 quantity) external {
        heap.push(Orderbook(price, quantity));
        uint256 i = heap.length;
        while (i > 1 && heap[i / 2 - 1].price < heap[i - 1].price) {
            Orderbook memory temp = heap[i/2 - 1];
            heap[i/2 - 1] = heap[i - 1];
            heap[i - 1] = temp;
            i = i / 2;
        }
    }
}
