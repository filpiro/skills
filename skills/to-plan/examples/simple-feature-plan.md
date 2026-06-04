# Goal

Add ingredient pricing support.

# Confirmed Decisions

- Prices come from APIs.
- DTO layer performs parsing.
- Frontend receives normalized data.

# Open Questions

None.

# Technical Approach

- Extend DTO parsing.
- Extend domain model.
- Update cart calculations.
- Display ingredient prices in UI.

# Implementation Phases

## Phase 1 - DTO Parsing

Parse ingredient prices from API responses.

## Phase 2 - Domain Model

Expose ingredient prices in the application model.

## Phase 3 - Cart Calculations

Include ingredient prices in totals.

## Phase 4 - UI

Display prices and updated totals.

# Testing Strategy

- Verify API parsing.
- Verify cart totals.
- Verify UI rendering.

# Risks

- Missing prices from API.
- Backward compatibility.

# Agent Handoff Notes

Implement phases sequentially.
Verify each phase before moving to the next.