xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$depositoCombinadoResponse" element="ns0:DepositoCombinadoResponse" location="../../xsds/TransaccionesAutobancos/XMLSchema_1271081668.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadedetallesdelacuentaResponse" element="ns0:ConsultadedetallesdelacuentaResponse" location="../../xsds/ConsultasCuenta/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:depositoACuentaResponse" location="../../xsds/DepositoACuenta/DepositoACuenta.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoACuenta/depositoACuentaOut/";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/depositoACuenta";

(: Función encargada de convertir tipoDeDeposito T24 a tipoDeDeposito generico :)
declare function getGenericDepositType ($t24DepositType as xs:string)  as xs:string { 
	if ($t24DepositType = ("DP.MN.MN","DP.VARIASMND.ME")) then (
		"CASH"
	) else if ($t24DepositType = "FICO.CHQ") then (
		"OWN_CHEQUE"
	) else if ($t24DepositType = "CLEARING") then (
		$t24DepositType
	) else if ($t24DepositType = "CLEARING.INTL") then (
		"INTL_CHEQUE_US"
	) else if ($t24DepositType = "COLL.INTL") then (
		"INTL_CHEQUE_NON_US"
	) else (
		"OTHER"
	)
 };
 
declare function xf:depositoACuentaOut($depositoCombinadoResponse as element(ns0:DepositoCombinadoResponse),
    $consultadedetallesdelacuentaResponse as element(ns0:ConsultadedetallesdelacuentaResponse),
    $branchName as xs:string)
    as element(ns1:depositoACuentaResponse) {
        	if (fn:string($depositoCombinadoResponse/Status/successIndicator/text()) = "Success") then (
		        <ns1:depositoACuentaResponse>
		            {
		                for $ID in $consultadedetallesdelacuentaResponse/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/ID,
		                    $ALTACCTID in $consultadedetallesdelacuentaResponse/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/ALTACCTID
		                return
		                    <ACCOUNT_NUMBER>{ concat($ID , "/", $ALTACCTID) }</ACCOUNT_NUMBER>
		            }
		            {
		                for $SHORTTITLE in $consultadedetallesdelacuentaResponse/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/SHORTTITLE
		                return
		                    <ACCOUNT_NAME>{ data($SHORTTITLE) }</ACCOUNT_NAME>
		            }
		            {
		                for $LRCRCCY in $depositoCombinadoResponse/TELLERFINANCIALSERVICESType/LRCRCCY
		                return
		                    <CURRENCY>{ data($LRCRCCY) }</CURRENCY>
		            }
		            {
		                let $gTRANSACTION := $depositoCombinadoResponse/TELLERFINANCIALSERVICESType/gTRANSACTION
		                return
		                    <DEPOSIT_ITEMS>
		                        {
		                            for $mTRANSACTION in $gTRANSACTION/mTRANSACTION
		                            return
		                                <DEPOSIT_ITEM>
		                                    <DEPOSIT_TYPE>{ getGenericDepositType(data($mTRANSACTION/TRANSACTION)) }</DEPOSIT_TYPE>
		                                    <AMOUNT>{ data($mTRANSACTION/AMOUNT) }</AMOUNT>
		                                    {
		                                        for $SURROGATEAC in $mTRANSACTION/SURROGATEAC
		                                        return
		                                            <CHEQUE_ACCOUNT>{ data($SURROGATEAC) }</CHEQUE_ACCOUNT>
		                                    }
		                                    {
		                                        for $CHEQUENUMBER in $mTRANSACTION/CHEQUENUMBER
		                                        return
		                                            <CHEQUE_NUMBER>{ data($CHEQUENUMBER) }</CHEQUE_NUMBER>
		                                    }
		                                    {
		                                        for $SORTCODE in $mTRANSACTION/SORTCODE
		                                        return
		                                            <BANK_CODE>{ data($SORTCODE) }</BANK_CODE>
		                                    }
		                                </DEPOSIT_ITEM>
		                        }
		                    </DEPOSIT_ITEMS>
		            }
		            {
		                let $result :=        
		                    for $NARRATIVE in $depositoCombinadoResponse/TELLERFINANCIALSERVICESType/gTRANSACTION/mTRANSACTION[1]/sgNARRATIVE/NARRATIVE
		                    return
		                        <DEPOSIT_REFERENCE>{ data($NARRATIVE) }</DEPOSIT_REFERENCE>
		                return
		                    $result[1]
		            }
		            {
		                let $result :=
		                    for $DATETIME in $depositoCombinadoResponse/TELLERFINANCIALSERVICESType/gDATETIME/DATETIME
		                    return
		                        <DATE_TIME>{ fn:concat("20",data($DATETIME)) }</DATE_TIME>
		                return
		                    $result[1]
		            }
		            {
		                let $INPUTTER := fn:tokenize(fn:string($depositoCombinadoResponse/TELLERFINANCIALSERVICESType/gINPUTTER/INPUTTER/text()),"_")
	                    return
	                        <INPUTTER>{ $INPUTTER[2] }</INPUTTER>
		            }
		            <BRANCH_NAME>{ $branchName }</BRANCH_NAME>
		        </ns1:depositoACuentaResponse>
        ) else (
        	<ns1:depositoACuentaResponse/>
        )
};

declare variable $depositoCombinadoResponse as element(ns0:DepositoCombinadoResponse) external;
declare variable $consultadedetallesdelacuentaResponse as element(ns0:ConsultadedetallesdelacuentaResponse) external;
declare variable $branchName as xs:string external;

xf:depositoACuentaOut($depositoCombinadoResponse,
    $consultadedetallesdelacuentaResponse,
    $branchName)