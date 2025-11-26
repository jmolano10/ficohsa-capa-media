xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$pagodeChequeFCYResponse1" element="ns0:PagodeChequeFCYResponse" location="../../xsds/TransaccionesAutobancos/XMLSchema_1271081668.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaDAOResponse1" element="ns0:ConsultaDAOResponse" location="../../xsds/Core/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadedetallesdelacuentaResponse1" element="ns0:ConsultadedetallesdelacuentaResponse" location="../../xsds/ConsultasCuenta/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoDeChequeResponse" location="../../xsds/PagoDeCheque/PagoDeCheque.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoDeCheque/pagoDeChequeFcyOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoDeCheque";
declare namespace ns0 = "T24WebServicesImpl";

declare function xf:pagoDeChequeFcyOut($pagodeChequeFCYResponse1 as element(ns0:PagodeChequeFCYResponse),
    $consultaDAOResponse1 as element(ns0:ConsultaDAOResponse),
    $consultadedetallesdelacuentaResponse1 as element(ns0:ConsultadedetallesdelacuentaResponse))
    as element(ns1:pagoDeChequeResponse) {
        if (fn:string($pagodeChequeFCYResponse1/Status/successIndicator/text()) = "Success") then (
	        <ns1:pagoDeChequeResponse>
	            {
	                let $ALTACCTID := fn:string($consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/ALTACCTID/text())
	                let $ACCOUNTID := fn:string($consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/ID/text())
	                return
	                    <ACCOUNT_NUMBER>{ fn:concat($ACCOUNTID,"/",$ALTACCTID) }</ACCOUNT_NUMBER>
	            }
	            {
	                for $SHORTTITLE in $consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/SHORTTITLE
	                return
	                    <ACCOUNT_NAME>{ data($SHORTTITLE) }</ACCOUNT_NAME>
	            }
	            {
	                for $CURRENCY2 in $pagodeChequeFCYResponse1/TELLERType/CURRENCY2
	                return
	                    <DEBIT_CURRENCY>{ data($CURRENCY2) }</DEBIT_CURRENCY>
	            }
	            {
	                for $AMOUNTFCY2 in $pagodeChequeFCYResponse1/TELLERType/AMOUNTFCY2
	                return
	                    <DEBIT_AMOUNT>{ data($AMOUNTFCY2) }</DEBIT_AMOUNT>
	            }
	            {
	                for $CHEQUENUMBER in $pagodeChequeFCYResponse1/TELLERType/gCHEQUENUMBER/mCHEQUENUMBER[1]/CHEQUENUMBER
	                return
	                    <CHEQUE_NUMBER>{ data($CHEQUENUMBER) }</CHEQUE_NUMBER>
	            }
	            {
	                let $result :=
	                    for $NARRATIVE2 in $pagodeChequeFCYResponse1/TELLERType/gNARRATIVE2/NARRATIVE2
	                    return
	                        <DESCRIPTION>{ data($NARRATIVE2) }</DESCRIPTION>
	                return
	                    $result[1]
	            }
	            {
	                let $result :=
	                    for $DATETIME in $pagodeChequeFCYResponse1/TELLERType/gDATETIME/DATETIME
	                    return
	                        <DATE_TIME>{ data($DATETIME) }</DATE_TIME>
	                return
	                    $result[1]
	            }
	            {
	                let $INPUTTER := fn:tokenize(fn:string($pagodeChequeFCYResponse1/TELLERType/gINPUTTER/INPUTTER/text()),"_")
                    return
                        <INPUTTER>{ $INPUTTER[2] }</INPUTTER>
	            }
	            {
	                for $NAME in $consultaDAOResponse1/WSADMINDEPTACCTOFFICERType[1]/gWSADMINDEPTACCTOFFICERDetailType/mWSADMINDEPTACCTOFFICERDetailType[1]/NAME
	                return
	                    <BRANCH_NAME>{ data($NAME) }</BRANCH_NAME>
	            }
	        </ns1:pagoDeChequeResponse>
	    ) else (
	    	<ns1:pagoDeChequeResponse/>
	    )
};

declare variable $pagodeChequeFCYResponse1 as element(ns0:PagodeChequeFCYResponse) external;
declare variable $consultaDAOResponse1 as element(ns0:ConsultaDAOResponse) external;
declare variable $consultadedetallesdelacuentaResponse1 as element(ns0:ConsultadedetallesdelacuentaResponse) external;

xf:pagoDeChequeFcyOut($pagodeChequeFCYResponse1,
    $consultaDAOResponse1,
    $consultadedetallesdelacuentaResponse1)
