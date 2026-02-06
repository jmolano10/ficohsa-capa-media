xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$creaCuentaClienteIN" element="ns0:creaCuentaCliente" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:CreaClienteSimplificado" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aperturaProductosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaCuentaCliente/xq/creaClienteSimplificadoIN/";

declare function xf:creaClienteSimplificadoIN($accountofficer as xs:string,
    $branchcode as xs:string,
    $creaCuentaClienteIN as element(ns0:creaCuentaCliente))
    as element(ns0:CreaClienteSimplificado) {
        <ns0:CreaClienteSimplificado>
            <TYPE>{ data($creaCuentaClienteIN/CUSTOMER_INFORMATION/TYPE) }</TYPE>
            <LEGAL_ID>{ data($creaCuentaClienteIN/CUSTOMER_INFORMATION/LEGAL_ID) }</LEGAL_ID>
            <CUSTOMER_ID>{ data($creaCuentaClienteIN/CUSTOMER_INFORMATION/CUSTOMER_ID) }</CUSTOMER_ID>
            <LEGAL_ISSUED_DATE>{ data($creaCuentaClienteIN/CUSTOMER_INFORMATION/LEGAL_ISSUED_DATE) }</LEGAL_ISSUED_DATE>
            <FIRST_NAME>{ normalize-space(data($creaCuentaClienteIN/CUSTOMER_INFORMATION/FIRST_NAME)) }</FIRST_NAME>
            <SECOND_NAME>{ normalize-space(data($creaCuentaClienteIN/CUSTOMER_INFORMATION/SECOND_NAME)) }</SECOND_NAME>
            <FIRST_LASTNAME>{ normalize-space(data($creaCuentaClienteIN/CUSTOMER_INFORMATION/FIRST_LASTNAME)) }</FIRST_LASTNAME>
            <SECOND_LASTNAME>{ normalize-space(data($creaCuentaClienteIN/CUSTOMER_INFORMATION/SECOND_LASTNAME) )}</SECOND_LASTNAME>
            <GENDER>{ data($creaCuentaClienteIN/CUSTOMER_INFORMATION/GENDER) }</GENDER>
            <MARITAL_STATUS>{ data($creaCuentaClienteIN/CUSTOMER_INFORMATION/MARITAL_STATUS) }</MARITAL_STATUS>
            <BIRTH_DATE>{ data($creaCuentaClienteIN/CUSTOMER_INFORMATION/BIRTH_DATE) }</BIRTH_DATE>
            <MONTHLY_TXN_VOLUME>{ data($creaCuentaClienteIN/CUSTOMER_INFORMATION/MONTHLY_TXN_VOLUME) }</MONTHLY_TXN_VOLUME>
            <ACCOUNT_OFFICER>{ $accountofficer }</ACCOUNT_OFFICER>
            <BRANCH_CODE>{ $branchcode }</BRANCH_CODE>
            <PHONE_INFO>
                {
                    for $PHONE_NUMBER_ITEM in $creaCuentaClienteIN/CUSTOMER_INFORMATION/PHONE_INFO/PHONE_NUMBER_ITEM
                    return
                        <PHONE_NUMBER_ITEM>
                            <PHONE_LOCATION>{ data($PHONE_NUMBER_ITEM/PHONE_LOCATION) }</PHONE_LOCATION>
                            <PHONE_TYPE>{ data($PHONE_NUMBER_ITEM/PHONE_TYPE) }</PHONE_TYPE>
                            <PHONE_NUMBER>{ data($PHONE_NUMBER_ITEM/PHONE_NUMBER) }</PHONE_NUMBER>
                            <PHONE_REFERENCE>{ data($PHONE_NUMBER_ITEM/PHONE_REFERENCE) }</PHONE_REFERENCE>
                            <ZIP_CODE>{ data($PHONE_NUMBER_ITEM/ZIP_CODE) }</ZIP_CODE>
                        </PHONE_NUMBER_ITEM>
                }
            </PHONE_INFO>
            <EMAIL_ADDRESS_INFO>
                {
                    for $EMAIL_ITEM in $creaCuentaClienteIN/CUSTOMER_INFORMATION/EMAIL_ADDRESS_INFO/EMAIL_ITEM
                    return
                        <EMAIL_ITEM>
                            <EMAIL_TYPE>{ data($EMAIL_ITEM/EMAIL_TYPE) }</EMAIL_TYPE>
                            <EMAIL>{ data($EMAIL_ITEM/EMAIL) }</EMAIL>
                            <IS_MAIN_ADDRESS>{ data($EMAIL_ITEM/IS_MAIN_ADDRESS) }</IS_MAIN_ADDRESS>
                        </EMAIL_ITEM>
                }
            </EMAIL_ADDRESS_INFO>
            <JOB_INFO>
                {
                    for $JOB_ITEM in $creaCuentaClienteIN/CUSTOMER_INFORMATION/JOB_INFO/JOB_ITEM
                    return
                        <JOB_ITEM>
                            <IS_WORK>{ data($JOB_ITEM/IS_WORK) }</IS_WORK>
                            {
                                for $PROFESION_CODE in $JOB_ITEM/PROFESION_CODE
                                return
                                    <PROFESION_CODE>{ data($PROFESION_CODE) }</PROFESION_CODE>
                            }
                            {
                                for $JOB_DESCRIPTION in $JOB_ITEM/JOB_DESCRIPTION
                                return
                                    <JOB_DESCRIPTION>{ data($JOB_DESCRIPTION) }</JOB_DESCRIPTION>
                            }
                            {
                                for $INCOME_SOURCE in $JOB_ITEM/INCOME_SOURCE
                                return
                                    <INCOME_SOURCE>{ data($INCOME_SOURCE) }</INCOME_SOURCE>
                            }
                            {
                                for $PRINCIPAL_INCOME_AMOUNT in $JOB_ITEM/PRINCIPAL_INCOME_AMOUNT
                                return
                                    <PRINCIPAL_INCOME_AMOUNT>{ data($PRINCIPAL_INCOME_AMOUNT) }</PRINCIPAL_INCOME_AMOUNT>
                            }
                        </JOB_ITEM>
                }
            </JOB_INFO>
            <ADDRESS_INFO>
                {
                    for $ADDRESS_ITEM in $creaCuentaClienteIN/CUSTOMER_INFORMATION/ADDRESS_INFO/ADDRESS_ITEM
                    return
                        <ADDRESS_ITEM>
                            <ADDRESS_TYPE>{ data($ADDRESS_ITEM/ADDRESS_TYPE) }</ADDRESS_TYPE>
                            <IS_MAIN_ADDRESS>{ data($ADDRESS_ITEM/IS_MAIN_ADDRESS) }</IS_MAIN_ADDRESS>
                            <COUNTRY_CODE>{ data($ADDRESS_ITEM/COUNTRY_CODE) }</COUNTRY_CODE>
                            <STATE_CODE>{ data($ADDRESS_ITEM/STATE_CODE) }</STATE_CODE>
                            <CITY_CODE>{ data($ADDRESS_ITEM/CITY_CODE) }</CITY_CODE>
                            <COLONY_CODE>{ data($ADDRESS_ITEM/COLONY_CODE) }</COLONY_CODE>
                            <NEIGHBORHOOD>{ data($ADDRESS_ITEM/NEIGHBORHOOD) }</NEIGHBORHOOD>
                            <AVENUE>{ data($ADDRESS_ITEM/AVENUE) }</AVENUE>
                            <STREET>{ data($ADDRESS_ITEM/STREET) }</STREET>
                            <BLOCK>{ data($ADDRESS_ITEM/BLOCK) }</BLOCK>
                            <HOUSE_NUMBER>{ data($ADDRESS_ITEM/HOUSE_NUMBER) }</HOUSE_NUMBER>
                            <REFERENCES>{ data($ADDRESS_ITEM/REFERENCES) }</REFERENCES>
                        </ADDRESS_ITEM>
                }
            </ADDRESS_INFO>
        </ns0:CreaClienteSimplificado>
};

declare variable $accountofficer as xs:string external;
declare variable $branchcode as xs:string external;
declare variable $creaCuentaClienteIN as element(ns0:creaCuentaCliente) external;

xf:creaClienteSimplificadoIN($accountofficer,
    $branchcode,
    $creaCuentaClienteIN)