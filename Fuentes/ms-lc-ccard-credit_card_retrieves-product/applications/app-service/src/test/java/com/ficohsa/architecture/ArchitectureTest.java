package com.ficohsa.architecture;

import com.tngtech.archunit.core.importer.ImportOption;
import com.tngtech.archunit.junit.AnalyzeClasses;
import com.tngtech.archunit.junit.ArchTest;
import com.tngtech.archunit.lang.ArchRule;

import static com.tngtech.archunit.lang.syntax.ArchRuleDefinition.noClasses;

@AnalyzeClasses(
        packages = "com.ficohsa",
        importOptions = {
                ImportOption.DoNotIncludeTests.class
        }
)
public class ArchitectureTest {

    @ArchTest
    static final ArchRule model_should_not_depend_on_usecase =
            noClasses()
                    .that().resideInAPackage("..model..")
                    .should().dependOnClassesThat()
                    .resideInAPackage("..usecase..");

    @ArchTest
    static final ArchRule model_should_not_depend_on_driven =
            noClasses()
                    .that().resideInAPackage("..model..")
                    .should().dependOnClassesThat()
                    .resideInAPackage("..driven..");

    @ArchTest
    static final ArchRule usecase_should_not_depend_on_driven =
            noClasses()
                    .that().resideInAPackage("..usecase..")
                    .should().dependOnClassesThat()
                    .resideInAPackage("..driven..");

    @ArchTest
    static final ArchRule usecase_should_not_depend_on_api =
            noClasses()
                    .that().resideInAPackage("..usecase..")
                    .should().dependOnClassesThat()
                    .resideInAPackage("..api..");
}
