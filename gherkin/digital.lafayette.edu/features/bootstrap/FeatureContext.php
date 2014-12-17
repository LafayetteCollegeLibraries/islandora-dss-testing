<?php

use Behat\Behat\Context\ClosuredContextInterface,
    Behat\Behat\Context\TranslatedContextInterface,
    Behat\Behat\Context\BehatContext,
    Behat\Behat\Exception\PendingException;
use Behat\Gherkin\Node\PyStringNode,
    Behat\Gherkin\Node\TableNode;

use Behat\MinkExtension\Context\MinkContext;

//
// Require 3rd-party libraries here:
//
require_once 'PHPUnit/Autoload.php';
require_once 'PHPUnit/Framework/Assert/Functions.php';
//

/**
 * Features context.
 */
class FeatureContext extends MinkContext
{
    /**
     * Initializes context.
     * Every scenario gets it's own context object.
     *
     * @param array $parameters context parameters (set them up through behat.yml)
     */
    public function __construct(array $parameters)
    {
        // Initialize your context here
    }

//
// Place your definition and hook methods here:
//
//    /**
//     * @Given /^I have done something with "([^"]*)"$/
//     */
//    public function iHaveDoneSomethingWith($argument)
//    {
//        doSomethingWith($argument);
//    }
//
    /**
     * @Given /^I am in the "([^"]*)" Collection$/
     */
    public function iAmInTheCollection($arg1)
    {
      $this->getSession()->visit('/collection/' . $arg1);

      assertEquals(true, false);
    }

    /**
     * @When /^I select the token "([^"]*)" for the field "([^"]*)"$/
     */
    public function iSelectTheTokenForTheField($arg1, $arg2)
    {
      $session = $this->getSession();
      $session->click('#MODS-mods-originInfo-publisher-s.islandora-solr-facet-list li.first a.active');
    }

    /**
     * @Then /^I should refine my results$/
     */
    public function iShouldRefineMyResults()
    {

      throw new PendingException();
    }

    /**
     * @When /^I submit the form with "([^"]*)"$/
     */
    public function iSubmitTheFormWith($arg1)
    {

      throw new PendingException();
    }

    /**
     * @When /^I submit the form "([^"]*)" with "([^"]*)"$/
     */
    public function iSubmitTheFormWith2($arg1, $arg2)
    {

      $page = $this->getSession()->getPage();
      $element = $page->find('css',$arg1 . " " . $arg2);
      $element->doubleClick();
    }

    /**
     * @When /^I click "([^"]*)" and wait for "([^"]*)"$/
     */
    public function iClickAndWaitFor($arg1, $arg2)
    {

      $page = $this->getSession()->getPage();
      $element = $page->find('css', $arg1);
      $element->click();
      $this->getSession()->wait(7500, "$('$arg2').length > 0");
    }

    /**
     * @Given /^I wait for "([^"]*)"$/
     */
    public function iWaitFor($arg1)
    {

      $this->getSession()->wait(7500, "$('$arg1:visible').length > 0");
    }

    /**
     * @Given /^print the "([^"]*)" element$/
     */
    public function printTheElement($arg1)
    {

      $page = $this->getSession()->getPage();
      $element = $page->find('css', $arg1);
    }

    /**
     * @When /^I change "([^"]*)"$/
     */
    public function iChange($arg1)
    {

      $this->getSession()->evaluateScript("(function($) { $(\" $arg1 \").change(); })(jQuery)");
    }

    /**
     * @Given /^I change "([^"]*)" from "([^"]*)"$/
     */
    public function iChangeFrom($arg1, $arg2)
    {

      $this->getSession()->evaluateScript("(function($) {

$(\" $arg2 \").attr('selected', null);
$(\" $arg1 \").attr('selected', 'selected');
$(\" $arg1 \").change();

})(jQuery)");

    }
}
