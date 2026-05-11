import { describe, it, expect } from 'vitest';
import { add, multiply, applyDiscount, isEven } from './math.js';

describe('Math functions', () => {
  it('should add two numbers', () => {
    expect(add(2, 3)).toBe(5);
  });

  it('should multiply two numbers', () => {
    expect(multiply(4, 5)).toBe(20);
  });

  it('should apply 10% discount on 1000 to give 900', () => {
    expect(applyDiscount(1000, 10)).toBe(900);
  });

  it('should handle 0% discount', () => {
    expect(applyDiscount(500, 0)).toBe(500);
  });

  it('should return true for even numbers', () => {
    expect(isEven(4)).toBe(true);
  });

  it('should return false for odd numbers', () => {
    expect(isEven(5)).toBe(false);
  });
});
