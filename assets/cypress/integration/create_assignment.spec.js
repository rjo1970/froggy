context("Assignment lifecycle", function () {
    it('can create new assignment', () => {
        cy.visit("http://localhost:4000/assignments/new");

        cy.get("#assignment_student").type("Example Student")
        cy.get("#assignment_subject").type("Example Subject")
        cy.get("#assignment_description").type("Example Description")
        cy.get("#assignment_due_date_year")
        cy.get("#assignment_due_date_month")
        cy.get("#assignment_due_date_day")
        cy.get("button").click()
        cy.url().should('match', /assignments\/\d+/)
        cy.get('.alert-info').should('contain', 'Assignment created successfully.')
        cy.get("#front-page").click()
    })
});