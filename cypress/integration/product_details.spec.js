describe('Product Details', () => {
    it('Navigates from home page to product detail page', () => {
      cy.visit('/');
  
      // Wait for the product elements to be visible
      cy.get('.products article').should('be.visible');
  
      // Get the first product element and click anywhere inside it
      cy.get('.products article').first().click();
  
      // Verify that the URL contains '/products/'
      cy.url().should('include', '/products/');
    });
  });