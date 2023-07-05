describe('Cart', () => {
    it('Increases cart count when adding a product', () => {
      cy.visit('/'); // Visit the home page
  
      cy.get('.products article').should('be.visible');

      cy.get('button').contains('Add').click({force: true});

      cy.get('.nav-item.end-0').should('contain', '1');
    });
  });