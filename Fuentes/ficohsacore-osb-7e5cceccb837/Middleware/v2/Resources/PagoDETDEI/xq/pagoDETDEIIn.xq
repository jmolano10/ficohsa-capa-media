(:: pragma bea:global-element-parameter parameter="$pagoDET" element="ns1:pagoDET" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/DEI/pagoDET/validarPagoDET/xsd/validarPagoDET_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validarPagoDET";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoDET/xq/pagoDETIn/";

declare function xf:pagoDETIn($pagoDET as element(ns1:pagoDET),
    $fechaRegistro as xs:string)
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:PV_RTN>{ data($pagoDET/RTN) }</ns2:PV_RTN>
            <ns2:PN_NUMEROSOLICITUD>{ data($pagoDET/BANK_BATCH_ID) }</ns2:PN_NUMEROSOLICITUD>
            <ns2:PD_FECHAREGISTRO>{ fn-bea:dateTime-from-string-with-format("yyyyMMddHHmm", $fechaRegistro) }</ns2:PD_FECHAREGISTRO>
            <ns2:PV_NUMEROCUENTA>
            { 
             let $PV_TIPO_PRODUCTO := $pagoDET/PAYMENT_INFORMATION/PAYMENT_METHOD/text()
                return
                if ($PV_TIPO_PRODUCTO = 'CREDIT_CARD') then
                 (
                    data($pagoDET/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER/text()) 
                 )
                 else(
                    data($pagoDET/ACCOUNT_NUMBER/text())
                 )  
            }
            </ns2:PV_NUMEROCUENTA>
            <ns2:PV_CODIGOMONEDA>{ data($pagoDET/CURRENCY) }</ns2:PV_CODIGOMONEDA>
            <ns2:PV_PERIODO>{ data($pagoDET/PERIOD) }</ns2:PV_PERIODO>
            <ns2:PN_TOTALAPAGAR>{ data($pagoDET/TOTAL_PAYMENT) }</ns2:PN_TOTALAPAGAR>
            <ns2:PV_NUMEROCONTRATO>{ data($pagoDET/CONTRACT_NUMBER) }</ns2:PV_NUMEROCONTRATO>
            <ns2:PV_DECLARACIONJURIDICA>{ data($pagoDET/JURIDICAL_DECLARATION_ID) }</ns2:PV_DECLARACIONJURIDICA>
            <ns2:PN_IMPUESTO>{ data($pagoDET/TAX_PAYMENT_ID) }</ns2:PN_IMPUESTO>
            <ns2:PN_CONCEPTO>{ data($pagoDET/TAX_CONCEPT_ID) }</ns2:PN_CONCEPTO>
            <ns2:PN_TOTALINFORMADO>{ data($pagoDET/TOTAL_PRESENTED) }</ns2:PN_TOTALINFORMADO>
            <ns2:PV_DECLAODECLARAPAGO>{ data($pagoDET/REQUEST_DET_TYPE) }</ns2:PV_DECLAODECLARAPAGO>
            <ns2:PV_IDUSUARIO>{ data($pagoDET/USER_ID) }</ns2:PV_IDUSUARIO>
            <ns2:PV_CONTRATOID>{ data($pagoDET/CONTRACT_ID) }</ns2:PV_CONTRATOID>
             <ns2:PT_TARPAGODETALLE>
              {
                for $i in 1 to count($pagoDET/PAYMENT_DETAILS/PAYMENT_DETAIL)
                return
                <ns2:ITEM>
                     <ns2:IMPUESTO>{ data($pagoDET/PAYMENT_DETAILS/PAYMENT_DETAIL[$i]/TAX) }</ns2:IMPUESTO>
                     <ns2:CONCEPTO>{ data($pagoDET/PAYMENT_DETAILS/PAYMENT_DETAIL[$i]/CONCEPT) }</ns2:CONCEPTO>
                     <ns2:SUBCONCEPTO>{ data($pagoDET/PAYMENT_DETAILS/PAYMENT_DETAIL[$i]/SUB_CONCEPT) }</ns2:SUBCONCEPTO>
                     <ns2:IMPORTE>{ data($pagoDET/PAYMENT_DETAILS/PAYMENT_DETAIL[$i]/AMOUNT) }</ns2:IMPORTE>
               </ns2:ITEM>
              }
             </ns2:PT_TARPAGODETALLE>
        </ns2:InputParameters>
};

declare variable $pagoDET as element(ns1:pagoDET) external;
declare variable $fechaRegistro as xs:string external;

xf:pagoDETIn($pagoDET,
    $fechaRegistro)