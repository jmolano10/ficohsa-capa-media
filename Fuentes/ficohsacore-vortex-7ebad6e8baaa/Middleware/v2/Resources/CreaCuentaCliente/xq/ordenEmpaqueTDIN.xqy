xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$creaCuentaCliente" element="ns0:creaCuentaCliente" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ordenEmpaqueTD" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aperturaProductosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaCuentaCliente/xq/ordenEmpaqueTDIN/";

declare function xf:ordenEmpaqueTDIN($branchCode as xs:string,
    $accountNumber as xs:string,
    $productType as xs:string,
    $costumerId as xs:string,
    $creaCuentaCliente as element(ns0:creaCuentaCliente))
    as element(ns0:ordenEmpaqueTD) {
        <ns0:ordenEmpaqueTD>
            <CUSTOMER_INFORMATION>
                <CODE>{ data($costumerId) }</CODE>
                <NAME>{ concat($creaCuentaCliente/CUSTOMER_INFORMATION/FIRST_NAME ,' ', $creaCuentaCliente/CUSTOMER_INFORMATION/SECOND_NAME ,' ', $creaCuentaCliente/CUSTOMER_INFORMATION/FIRST_LASTNAME ,' ', $creaCuentaCliente/CUSTOMER_INFORMATION/SECOND_LASTNAME) }</NAME>
                <LEGAL_ID>{ data($creaCuentaCliente/CUSTOMER_INFORMATION/LEGAL_ID) }</LEGAL_ID>
                <EMAIL>{ data($creaCuentaCliente/CUSTOMER_INFORMATION/EMAIL_ADDRESS_INFO/EMAIL_ITEM[1]/EMAIL) }</EMAIL>
            </CUSTOMER_INFORMATION>
            {
                let $PHONE_INFO := $creaCuentaCliente/CUSTOMER_INFORMATION/PHONE_INFO
                return
                    <PHONE_INFO>
                        {
                            for $PHONE_NUMBER_ITEM in $PHONE_INFO/PHONE_NUMBER_ITEM
                            return
                                <PHONE_NUMBER_ITEM>
                                    <PHONE_TYPE>{ data($PHONE_NUMBER_ITEM/PHONE_TYPE) }</PHONE_TYPE>
                                    <PHONE_NUMBER>{ data($PHONE_NUMBER_ITEM/PHONE_NUMBER) }</PHONE_NUMBER>
                                </PHONE_NUMBER_ITEM>
                        }
                    </PHONE_INFO>
            }
            {
                let $DELIVERY_ADDRESS_INFO := $creaCuentaCliente/PACKAGING_INFORMATION/DELIVERY_ADDRESS_INFO
                return
                    <ADDRESS_INFO>
                        {
                            for $ADDRESS_ITEM in $DELIVERY_ADDRESS_INFO/ADDRESS_ITEM
                            return
                                <ADDRESS_ITEM>
                                    <ADDRESS_TYPE>{ data($ADDRESS_ITEM/ADDRESS_TYPE) }</ADDRESS_TYPE>
                                    <ADDRESS_LINE>{ data($ADDRESS_ITEM/ADDRESS_LINE) }</ADDRESS_LINE>
                                    <IS_DELIVERY_ADDRESS>{ data($ADDRESS_ITEM/IS_DELIVERY_ADDRESS) }</IS_DELIVERY_ADDRESS>
                                </ADDRESS_ITEM>
                        }
                    </ADDRESS_INFO>
            }
            {
                let $JOB_INFO := $creaCuentaCliente/CUSTOMER_INFORMATION/JOB_INFO
                return
                    <JOB_INFO>
                        {
                            for $JOB_ITEM in $JOB_INFO/JOB_ITEM
                            return
                                <JOB_ITEM>
                                    <JOB_DESCRIPTION>{ data($JOB_ITEM/JOB_DESCRIPTION) }</JOB_DESCRIPTION>
                                </JOB_ITEM>
                        }
                    </JOB_INFO>
            }
            {
                let $CARD_INFORMATION := $creaCuentaCliente/CARD_INFORMATION
                return
                    <CARD_INFORMATION>
                        {
                            for $CARD_NUMBER in $CARD_INFORMATION/CARD_NUMBER
                            return
                                <LAST_CARD_NUMBER>{ data($CARD_NUMBER) }</LAST_CARD_NUMBER>
                        }
                        <TYPE>{ $productType }</TYPE>
                        <BRANCH_CODE>{ $branchCode }</BRANCH_CODE>
                    </CARD_INFORMATION>
            }
            <ACCOUNT_INFORMATION>
                <ACCOUNT_NUMBER>{ $accountNumber }</ACCOUNT_NUMBER>
                <ACCOUNT_CURRENCY>{ data($creaCuentaCliente/ACCOUNT_INFORMATION/CURRENCY) }</ACCOUNT_CURRENCY>
            </ACCOUNT_INFORMATION>
        </ns0:ordenEmpaqueTD>
};

declare variable $branchCode as xs:string external;
declare variable $accountNumber as xs:string external;
declare variable $productType as xs:string external;
declare variable $costumerId as xs:string external;
declare variable $creaCuentaCliente as element(ns0:creaCuentaCliente) external;

xf:ordenEmpaqueTDIN($branchCode,
    $accountNumber,
    $productType,
    $costumerId,
    $creaCuentaCliente)