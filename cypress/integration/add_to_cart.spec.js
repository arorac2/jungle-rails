describe('Cart', () => {
    it('Increases cart count when adding a product', () => {
      cy.visit('/'); // Visit the home page
  
      // Wait for the product elements to be visible
      cy.get('.products article').should('be.visible');

      cy.get('button').contains('Add').click({force: true});
    //   // Get the first product element and click on it
    //   cy.get('.products article').first().click();
  
    //   // Verify that the URL contains '/products/'
    //   cy.url().should('include', '/products/');
  
      // Go back to the home page
      
  
// Wait for the cart count to update
      cy.get('.nav-item.end-0').should('contain', '1');
    });
  });