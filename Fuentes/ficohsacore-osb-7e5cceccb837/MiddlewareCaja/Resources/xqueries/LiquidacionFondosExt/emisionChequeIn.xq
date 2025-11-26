(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$liquidacionFondosExt1" element="ns1:liquidacionFondosExt" location="../../xsds/LiquidacionFondosExt/LiquidacionFondosExt.xsd" ::)
(:: pragma bea:global-element-return element="ns0:EmisiondechqdegerenciaTT" location="../../xsds/ChequeGerencia/XMLSchema_-1805424041.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/liquidacionFondosExtTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/LiquidacionFondosExt/emisionChequeIn/";

declare function zeroReplace($value as xs:string?) as xs:string {
	if ($value = "" or fn:empty($value)) then (
		"0.00"
	) else (
		$value
	)
};

declare function xf:emisionChequeIn($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $liquidacionFondosExt1 as element(ns1:liquidacionFondosExt),
    $uuid as xs:string,
    $debitAccount as xs:string,
    $amount as xs:string,
    $balances as xs:string)
    as element(ns0:EmisiondechqdegerenciaTT) {
        <ns0:EmisiondechqdegerenciaTT>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader1/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader1/Password) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>{ $uuid }</messageId>
            </OfsFunction>
            <FUNDSTRANSFERFICOCASHIERCHEQUEType>
                <DebitAccountNo>{ $debitAccount }</DebitAccountNo>
                <CashierChequeAmount>{ $amount }</CashierChequeAmount>
                <LRCOMNCOLLECT>NO</LRCOMNCOLLECT>
                <gPAYMENTDETAILS>
                    {
						let $balancesList := fn:tokenize($balances,"!")
	                		return
	                		(
		          				<Description>{ fn:string($liquidacionFondosExt1/ASSET_ID/text()) }</Description>,
		          				<Description>{ zeroReplace($balancesList[3]) }</Description>,
								<Description>{ zeroReplace($balancesList[4]) }</Description>,
		          				<Description>{ zeroReplace($balancesList[5]) }</Description>	          				
		          			)
                    }
                </gPAYMENTDETAILS>
                {
                    for $BENEFICIARY_NAME in $liquidacionFondosExt1/CASHIER_CHECK/BENEFICIARY_NAME
                    return
                        <LRBENNAME>{ data($BENEFICIARY_NAME) }</LRBENNAME>
                }
                {
                    for $CHEQUE_NUMBER in $liquidacionFondosExt1/CASHIER_CHECK/CHEQUE_NUMBER
                    return
                        <LRCHQNOCONFRM>{ data($CHEQUE_NUMBER) }</LRCHQNOCONFRM>
                }
            </FUNDSTRANSFERFICOCASHIERCHEQUEType>
        </ns0:EmisiondechqdegerenciaTT>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $liquidacionFondosExt1 as element(ns1:liquidacionFondosExt) external;
declare variable $uuid as xs:string external;
declare variable $debitAccount as xs:string external;
declare variable $amount as xs:string external;
declare variable $balances as xs:string external;

xf:emisionChequeIn($autenticacionRequestHeader1,
    $liquidacionFondosExt1,
    $uuid,
    $debitAccount,
    $amount,
    $balances)