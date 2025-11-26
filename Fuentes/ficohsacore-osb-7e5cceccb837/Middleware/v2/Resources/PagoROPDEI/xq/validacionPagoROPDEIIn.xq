(:: pragma bea:global-element-parameter parameter="$pagoROP" element="ns0:pagoROP" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/DEI/pagoROP/validarPagoROP/xsd/validarPagoROP_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validarPagoROP";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoROPDEI/xq/validacionPagoROPDEIIn/";

declare function xf:validacionPagoROPDEIIn($pagoROP as element(ns0:pagoROP),
    $requestHeader as element(ns2:RequestHeader),
    $fechaRegistro as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_RTN>{ data($pagoROP/RTN) }</ns1:PV_RTN>
            <ns1:PV_TIPOPERSONA>{ data($pagoROP/PERSON_TYPE) }</ns1:PV_TIPOPERSONA>
            <ns1:PV_CODIGOISOMONEDA>{ data($pagoROP/CURRENCY) }</ns1:PV_CODIGOISOMONEDA>
            <ns1:PV_NUMEROCONTRATO>T24CONTRACTID</ns1:PV_NUMEROCONTRATO>
            <ns1:PN_CODIGOCONCEPTO>{ data($pagoROP/TAX_CONCEPT_ID) }</ns1:PN_CODIGOCONCEPTO>
            <ns1:PN_CODIGOIMPUESTO>{ data($pagoROP/TAX_PAYMENT_ID) }</ns1:PN_CODIGOIMPUESTO>
            <ns1:PN_TOTALAPAGAR>{ data($pagoROP/TOTAL_PAYMENT) }</ns1:PN_TOTALAPAGAR>
            <ns1:PN_MONTODEBITAR>{ data($pagoROP/AMOUNT) }</ns1:PN_MONTODEBITAR>
            <ns1:PN_MULTA>{ data($pagoROP/PENALTY_FEE) }</ns1:PN_MULTA>
            <ns1:PN_RECARGO>{ data($pagoROP/SURCHARGE_PAYMENT) }</ns1:PN_RECARGO>
            <ns1:PN_INTERESES>{ data($pagoROP/INTEREST_PAYMENT) }</ns1:PN_INTERESES>
            <ns1:PN_MES>{ data($pagoROP/MONTH) }</ns1:PN_MES>
            <ns1:PN_ANIO>{ data($pagoROP/YEAR) }</ns1:PN_ANIO>
            <ns1:PD_FECHAREGISTRO>{ fn-bea:dateTime-from-string-with-format("yyyyMMddHHmm", $fechaRegistro)}</ns1:PD_FECHAREGISTRO>
        </ns1:InputParameters>
};

declare variable $pagoROP as element(ns0:pagoROP) external;
declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $fechaRegistro as xs:string external;

xf:validacionPagoROPDEIIn($pagoROP,
    $requestHeader,
    $fechaRegistro)