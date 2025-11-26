(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns0:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Retiroenmonedalocal" location="../../xsds/RetirosYPagos/XMLSchema_1006378181.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/LiquidacionFondosExt/retiroFondoIn/";

declare function zeroReplace($value as xs:string?) as xs:string {
	if ($value = "" or fn:empty($value)) then (
		"0.00"
	) else (
		$value
	)
};

declare function xf:retiroFondoIn($autenticacionRequestHeader1 as element(ns0:AutenticacionRequestHeader),
    $debitAccount as xs:string,
    $debitAmount as xs:string,
    $txnReference as xs:string,
    $balances as xs:string,
    $uuid as xs:string)
    as element(ns1:Retiroenmonedalocal) {
        <ns1:Retiroenmonedalocal>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader1/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader1/Password) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl/>
                <messageId>{ $uuid }</messageId>
                <noOfAuth>1</noOfAuth>
                <replace/>
            </OfsFunction>
            <TELLERFICOLCYCASHWDLWSType>
                <gACCOUNT1>
                    <mACCOUNT1>
                        <AMOUNTLOCAL1>{ $debitAmount }</AMOUNTLOCAL1>
                    </mACCOUNT1>
                </gACCOUNT1>
                <ACCOUNT2>{ $debitAccount }</ACCOUNT2>
                <gNARRATIVE2>
                {
					let $narrativeList := fn:tokenize($txnReference,"!")
					let $balancesList := fn:tokenize($balances,"!")
                		return
                		(
	          				<NARRATIVE>{ $narrativeList[1] }</NARRATIVE>,
	          				<NARRATIVE>{ fn:substring($narrativeList[2],1,34) }</NARRATIVE>,
	          				<NARRATIVE>{ zeroReplace($balancesList[1]) }</NARRATIVE>,
	          				<NARRATIVE>{ zeroReplace($balancesList[2]) }</NARRATIVE>,
	          				<NARRATIVE>--------------------</NARRATIVE>,
	          				<NARRATIVE>{ zeroReplace($balancesList[3]) }</NARRATIVE>,
							<NARRATIVE>{ zeroReplace($balancesList[4]) }</NARRATIVE>,
	          				<NARRATIVE>{ zeroReplace($balancesList[5]) }</NARRATIVE>	          				
	          			)
                }
                </gNARRATIVE2>
            </TELLERFICOLCYCASHWDLWSType>
        </ns1:Retiroenmonedalocal>
};

declare variable $autenticacionRequestHeader1 as element(ns0:AutenticacionRequestHeader) external;
declare variable $debitAccount as xs:string external;
declare variable $debitAmount as xs:string external;
declare variable $txnReference as xs:string external;
declare variable $balances as xs:string external;
declare variable $uuid as xs:string external;

xf:retiroFondoIn($autenticacionRequestHeader1,
    $debitAccount,
    $debitAmount,
    $txnReference,
    $balances,
    $uuid)