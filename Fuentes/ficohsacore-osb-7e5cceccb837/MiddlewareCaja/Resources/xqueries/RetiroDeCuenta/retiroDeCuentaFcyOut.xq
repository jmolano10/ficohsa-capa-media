(:: pragma bea:global-element-parameter parameter="$retirodeefecenmonextranjeraResponse1" element="ns0:RetirodeefecenmonextranjeraResponse" location="../../xsds/RetirosYPagos/XMLSchema_1006378181.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadedetallesdelacuentaResponse1" element="ns0:ConsultadedetallesdelacuentaResponse" location="../../xsds/ConsultasCuenta/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:retiroDeCuentaResponse" location="../../xsds/RetiroDeCuenta/RetiroDeCuenta.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/retiroDeCuenta";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RetiroDeCuenta/retiroDeCuentaFcyOut/";

declare function xf:retiroDeCuentaFcyOut($retirodeefecenmonextranjeraResponse1 as element(ns0:RetirodeefecenmonextranjeraResponse),
    $consultadedetallesdelacuentaResponse1 as element(ns0:ConsultadedetallesdelacuentaResponse),
    $branchName as xs:string)
    as element(ns1:retiroDeCuentaResponse) {
    	if (fn:string($retirodeefecenmonextranjeraResponse1/Status/successIndicator/text()) = "Success") then (
	        <ns1:retiroDeCuentaResponse>
	            {
	                for $ID in $consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/ID,
	                    $ALTACCTID in $consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/ALTACCTID
	                return
	                    <ACCOUNT_NUMBER>{ concat($ID , "/", $ALTACCTID) }</ACCOUNT_NUMBER>
	            }
	            {
	                for $SHORTTITLE in $consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/SHORTTITLE
	                return
	                    <ACCOUNT_NAME>{ data($SHORTTITLE) }</ACCOUNT_NAME>
	            }
	            {
	                for $CURRENCY2 in $retirodeefecenmonextranjeraResponse1/TELLERType/CURRENCY2
	                return
	                    <DEBIT_CURRENCY>{ data($CURRENCY2) }</DEBIT_CURRENCY>
	            }
	            {
	                for $AMOUNTFCY2 in $retirodeefecenmonextranjeraResponse1/TELLERType/AMOUNTFCY2
	                return
	                    <DEBIT_AMOUNT>{ data($AMOUNTFCY2) }</DEBIT_AMOUNT>
	            }
	            {
	                for $CURRENCY2 in $retirodeefecenmonextranjeraResponse1/TELLERType/CURRENCY2
	                return
	                    <WITHDRAWAL_CURRENCY>{ data($CURRENCY2) }</WITHDRAWAL_CURRENCY>
	            }
	            {
	                for $AMOUNTFCY2 in $retirodeefecenmonextranjeraResponse1/TELLERType/AMOUNTFCY2
	                return
	                    <WITHDRAWAL_AMOUNT>{ data($AMOUNTFCY2) }</WITHDRAWAL_AMOUNT>
	            }
	            {
	                let $result :=
	                    for $NARRATIVE2 in $retirodeefecenmonextranjeraResponse1/TELLERType/gNARRATIVE2/NARRATIVE2
	                    return
	                        <DESCRIPTION>{ data($NARRATIVE2) }</DESCRIPTION>
	                return
	                    $result[1]
	            }
	            {
	                let $result :=
	                    for $DATETIME in $retirodeefecenmonextranjeraResponse1/TELLERType/gDATETIME/DATETIME
	                    return
	                        <DATE_TIME>{ fn:concat("20",data($DATETIME)) }</DATE_TIME>
	                return
	                    $result[1]
	            }
	            {
	                let $INPUTTER := fn:tokenize(fn:string($retirodeefecenmonextranjeraResponse1/TELLERType/gINPUTTER/INPUTTER/text()),"_")
	                return
	                    <INPUTTER>{ $INPUTTER[2] }</INPUTTER>
	            }
                <BRANCH_NAME>{ $branchName }</BRANCH_NAME>

	        </ns1:retiroDeCuentaResponse>
	    ) else (
	    	<ns1:retiroDeCuentaResponse/>
	    )
};

declare variable $retirodeefecenmonextranjeraResponse1 as element(ns0:RetirodeefecenmonextranjeraResponse) external;
declare variable $consultadedetallesdelacuentaResponse1 as element(ns0:ConsultadedetallesdelacuentaResponse) external;
declare variable $branchName as xs:string external;

xf:retiroDeCuentaFcyOut($retirodeefecenmonextranjeraResponse1,
    $consultadedetallesdelacuentaResponse1,
    $branchName)