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

      throw new PendingException();
    }

    /**
     * @When /^I select the token "([^"]*)" for the field "([^"]*)"$/
     */
    public function iSelectTheTokenForTheField($arg1, $arg2)
    {
      $session = $this->getSession();
      $session->click('#MODS-mods-originInfo-publisher-s.islandora-solr-facet-list li.first a.active');
      //$session->wait();

      //$this->getSession()->wat

      throw new PendingException();
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

      //$selector = new \Behat\Mink\Selector\NamedSelector();
      //$handler  = new \Behat\Mink\Selector\SelectorsHandler(array('submit' => $selector));

      //$this->getSession()->getPage()->findById($arg1)->click();

      //throw new PendingException();
    }

    /**
     * @When /^I submit the form "([^"]*)" with "([^"]*)"$/
     */
    public function iSubmitTheFormWith2($arg1, $arg2)
    {

      $page = $this->getSession()->getPage();
      $element = $page->find('css',$arg1 . " " . $arg2);
      $element->doubleClick();
      //throw new PendingException();
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

      //throw new PendingException();
    }

    /**
     * @Given /^I wait for "([^"]*)"$/
     */
    public function iWaitFor($arg1)
    {

      $this->getSession()->wait(7500, "$('$arg1:visible').length > 0");

      //throw new PendingException();
    }

}
