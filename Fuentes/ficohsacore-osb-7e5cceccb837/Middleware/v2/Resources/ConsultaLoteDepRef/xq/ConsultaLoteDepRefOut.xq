(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns2:OutputParameters" location="../../../BusinessServices/ABK/consultarLoteDepRef/xsd/consultarLoteDepRef_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaLoteResponse" location="../../DepositosReferenciados/xsd/depositosReferenciadosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/depositosReferenciadosTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarLoteDepRef";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/PagingTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaLoteDepRef/xq/ConsultaLoteDepRefOut/";

declare function xf:ConsultaLoteDepRefOut($outputParameters1 as element(ns2:OutputParameters))
    as element(ns0:consultaLoteResponse) {
        <ns0:consultaLoteResponse>
            {
                for $PV_CODIGOCLIENTE in $outputParameters1/ns2:PV_CODIGOCLIENTE
                return
                    <CUSTOMER_ID>{ data($PV_CODIGOCLIENTE) }</CUSTOMER_ID>
            }
            {
                for $PN_NROLOTE in $outputParameters1/ns2:PN_NROLOTE
                return
                    <BANK_BATCH_ID>{ data($PN_NROLOTE) }</BANK_BATCH_ID>
            }
            {
                for $PV_NROCUENTA in $outputParameters1/ns2:PV_NROCUENTA
                return
                    <ACCOUNT_NUMBER>{ data($PV_NROCUENTA) }</ACCOUNT_NUMBER>
            }
            <RECORDS_INFO>
                <INITIAL_RECORD>{ data($outputParameters1/ns2:PN_REGINICIAL) }</INITIAL_RECORD>
                <RECORDS_RETURNED>{ data($outputParameters1/ns2:PN_CANTREGISTROS) }</RECORDS_RETURNED>
                <RECORD_TOTAL>{ data($outputParameters1/ns2:PN_TOTREGISTROS) }</RECORD_TOTAL>
            </RECORDS_INFO>
            <DEBTORS>
            	{
                	let $DEBTOR := $outputParameters1/ns2:PT_CODIGOS/ns2:ITEM
                    for $i in 1 to count($DEBTOR)
                    return
	                <DEBTOR>
	                    <DEBTOR_CODE>{ data($outputParameters1/ns2:PT_CODIGOS/ns2:ITEM[$i]) }</DEBTOR_CODE>
	                    <DEBTOR_NAME>{ data($outputParameters1/ns2:PT_NOMBRES/ns2:ITEM[$i]) }</DEBTOR_NAME>
	                    <DOCUMENT_ID>{ data($outputParameters1/ns2:PT_IDDOCUMENTOS/ns2:ITEM[$i]) }</DOCUMENT_ID>
	                    <STATUS>{ data($outputParameters1/ns2:PT_ESTADOS/ns2:ITEM[$i]) }</STATUS>
                    	<DESCRIPTION>{ data($outputParameters1/ns2:PT_ESTADOSDESC/ns2:ITEM[$i]) }</DESCRIPTION>                    
                	</DEBTOR>
                }
            </DEBTORS>
        </ns0:consultaLoteResponse>
};

declare variable $outputParameters1 as element(ns2:OutputParameters) external;

xf:ConsultaLoteDepRefOut($outputParameters1)