(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudoAbanks" element="ns1:consultaRecaudoAbanks" location="../../xsds/ConsultaRecaudoAbanks/ConsultaRecaudoAbanks.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../xsds/ConsultaRecaudoAbanks/consultaRecaudoAbanks/ORA_BANK_OSB_K_INTEGRACION_CONVENIOS_CONSULTA_COBRANZA_ABANKS.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoAbanksTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K_INTEGRACION_CONVENIOS/CONSULTA_COBRANZA_ABANKS/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoAbanks/ConsultaRecaudoAbanksIn/";

declare function xf:ConsultaRecaudoAbanksIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaRecaudoAbanks as element(ns1:consultaRecaudoAbanks))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:CONTRACT_ID>{ data($consultaRecaudoAbanks/CONTRACT_ID) }</ns0:CONTRACT_ID>
            <ns0:DEBTOR_CODE>{ data($consultaRecaudoAbanks/DEBTOR_CODE) }</ns0:DEBTOR_CODE>
            {
                let $NUMBER_OF_BILLS := fn:string($consultaRecaudoAbanks/NUMBER_OF_BILLS/text())
                return
                	if($NUMBER_OF_BILLS != "") then (
                    	<ns0:NUMBER_OF_BILLS>{ data($NUMBER_OF_BILLS) }</ns0:NUMBER_OF_BILLS>
                    ) else (
                    	<ns0:NUMBER_OF_BILLS>0</ns0:NUMBER_OF_BILLS>
                    )
            }
            <ns0:BILL_NUMBER>{ data($consultaRecaudoAbanks/BILL_NUMBER) }</ns0:BILL_NUMBER>
            <ns0:CURRENCY>{ data($consultaRecaudoAbanks/CURRENCY) }</ns0:CURRENCY>
            {
                let $ADDITIONAL_INFO := fn:string($consultaRecaudoAbanks/ADDITIONAL_INFO/text())
                return
                	if($ADDITIONAL_INFO != "") then (
                    	<ns0:ADDITIONAL_INFO>{ data($ADDITIONAL_INFO) }</ns0:ADDITIONAL_INFO>
                    ) else (
                    	<ns0:ADDITIONAL_INFO>0</ns0:ADDITIONAL_INFO>
                    )
            }
            <ns0:USERNAME>{ data($autenticacionRequestHeader/UserName) }</ns0:USERNAME>
        </ns0:InputParameters>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaRecaudoAbanks as element(ns1:consultaRecaudoAbanks) external;

xf:ConsultaRecaudoAbanksIn($autenticacionRequestHeader,
    $consultaRecaudoAbanks)