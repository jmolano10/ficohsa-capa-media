xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:ws_gestiones" location="../../../BusinessServices/SALESFORCE/creaGestionGenerica/wsdl/creaGestionGenerica.wsdl" ::)

declare namespace ns0 = "http://soap.sforce.com/schemas/class/ws_gestiones";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/IngresaTarjetaBeneficio/xq/creaGestionGenericaIn/";

declare function xf:creaGestionGenericaIn($accountOrg as xs:string,
    $codigoPaf as xs:string,
    $producto as xs:string,
    $tipo as xs:string,
    $dualInd as xs:string,
    $diaPago as xs:string,
    $referencia as xs:string,
    $notificar as xs:string,
    $flujoAfiliacion as xs:string,
    $flujoReafiliacion as xs:string,
    $branch as xs:string,
    $type as xs:string,
    $nextStep as xs:string,
    $country as xs:string,
    $cardNumber as xs:string,
    $customerId as xs:string,
    $accountNumber as xs:string)
    as element(ns0:ws_gestiones) {
        <ns0:ws_gestiones>
            <ns0:parameters>
                <ns0:field>
                    <ns0:key>CLIENT_ID</ns0:key>
                    <ns0:value>{ $customerId }</ns0:value>
                </ns0:field>
                <ns0:field>
                    <ns0:key>ACCOUNT_NUMBER</ns0:key>
                    <ns0:value>{ $accountNumber }</ns0:value>
                </ns0:field>
                <ns0:field>
                    <ns0:key>ACCOUNT_ORG</ns0:key>
                    <ns0:value>{ $accountOrg }</ns0:value>
                </ns0:field>
                <ns0:field>
                    <ns0:key>CARD_NUMBER</ns0:key>
                    <ns0:value>{ $cardNumber }</ns0:value>
                </ns0:field>
                <ns0:field>
                    <ns0:key>CODIGO_PAF</ns0:key>
                    <ns0:value>{ $codigoPaf }</ns0:value>
                </ns0:field>
                <ns0:field>
                    <ns0:key>PRODUCTO</ns0:key>
                    <ns0:value>{ $producto }</ns0:value>
                </ns0:field>
                <ns0:field>
                    <ns0:key>TIPO</ns0:key>
                    <ns0:value>{ $tipo }</ns0:value>
                </ns0:field>
                <ns0:field>
                    <ns0:key>DUAL_IND</ns0:key>
                    <ns0:value>{ $dualInd }</ns0:value>
                </ns0:field>
                <ns0:field>
                    <ns0:key>DIA_PAGO</ns0:key>
                    <ns0:value/>
                </ns0:field>
                <ns0:field>
                    <ns0:key>REFERENCIA</ns0:key>
                    <ns0:value>{ $referencia }</ns0:value>
                </ns0:field>
                <ns0:field>
                    <ns0:key>NOTIFICAR</ns0:key>
                    <ns0:value>{ $notificar }</ns0:value>
                </ns0:field>
                <ns0:field>
                    <ns0:key>FLUJO_AFILIACION</ns0:key>
                    <ns0:value>{ $flujoAfiliacion }</ns0:value>
                </ns0:field>
                <ns0:field>
                    <ns0:key>FLUJO_REAFILIACION</ns0:key>
                    <ns0:value>{ $flujoReafiliacion }</ns0:value>
                </ns0:field>
            </ns0:parameters>
            <ns0:country>{ $country }</ns0:country>
            <ns0:branch>{ $branch }</ns0:branch>
            <ns0:type>{ $type }</ns0:type>
            <ns0:next_step>{ $nextStep }</ns0:next_step>
        </ns0:ws_gestiones>
};

declare variable $accountOrg as xs:string external;
declare variable $codigoPaf as xs:string external;
declare variable $producto as xs:string external;
declare variable $tipo as xs:string external;
declare variable $dualInd as xs:string external;
declare variable $diaPago as xs:string external;
declare variable $referencia as xs:string external;
declare variable $notificar as xs:string external;
declare variable $flujoAfiliacion as xs:string external;
declare variable $flujoReafiliacion as xs:string external;
declare variable $branch as xs:string external;
declare variable $type as xs:string external;
declare variable $nextStep as xs:string external;
declare variable $country as xs:string external;
declare variable $cardNumber as xs:string external;
declare variable $customerId as xs:string external;
declare variable $accountNumber as xs:string external;

xf:creaGestionGenericaIn($accountOrg,
    $codigoPaf,
    $producto,
    $tipo,
    $dualInd,
    $diaPago,
    $referencia,
    $notificar,
    $flujoAfiliacion,
    $flujoReafiliacion,
    $branch,
    $type,
    $nextStep,
    $country,
    $cardNumber,
    $customerId,
    $accountNumber)