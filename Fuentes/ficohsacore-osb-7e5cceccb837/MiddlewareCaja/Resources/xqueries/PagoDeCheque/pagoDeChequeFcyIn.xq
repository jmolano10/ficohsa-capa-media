(:: pragma bea:global-element-parameter parameter="$pagoDeCheque1" element="ns1:pagoDeCheque" location="../../xsds/PagoDeCheque/PagoDeCheque.xsd" ::)
(:: pragma bea:global-element-return element="ns0:PagodeChequeFCY" location="../../xsds/TransaccionesAutobancos/XMLSchema_1271081668.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoDeCheque";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoDeCheque/pagoDeChequeFcyIn/";

declare function xf:pagoDeChequeFcyIn($pagoDeCheque1 as element(ns1:pagoDeCheque),
    $accountCurrency as xs:string,
    $username as xs:string,
    $password as xs:string,
    $uuid as xs:string)
    as element(ns0:PagodeChequeFCY) {
        <ns0:PagodeChequeFCY>
            <WebRequestCommon>
                <userName>{ $username }</userName>
                <password>{ $password }</password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>{ $uuid }</messageId>
            </OfsFunction>
            <TELLERFICOFCYCASHCHQType>
                <WithdrawalCurrency>{ $accountCurrency }</WithdrawalCurrency>
                <gACCOUNT1>
                    <mACCOUNT1>
                        <WithdrawalAmount>{ data($pagoDeCheque1/CHEQUE_AMOUNT) }</WithdrawalAmount>
                    </mACCOUNT1>
                </gACCOUNT1>
                <Account>{ data($pagoDeCheque1/ACCOUNT_NUMBER) }</Account>
                <gNARRATIVE2>
	            {
                	let $channel := data($pagoDeCheque1/CHANNEL)
                	let $depositorId := data($pagoDeCheque1/DEPOSITOR_ID)
                	let $depositorName := data($pagoDeCheque1/DEPOSITOR_NAME)
                	let $description := data($pagoDeCheque1/DESCRIPTION)
                	return(
	                	if($channel != '')then(
	                		<Narrative>{ $channel }</Narrative>
	                	)else(),
	                	if($depositorId != '')then(
	                		<Narrative>{ $depositorId }</Narrative>
	                	)else(),
	                	if($depositorName != '')then(
	                		<Narrative>{ $depositorName }</Narrative>
	                	)else(),
	                	if($description != '')then(
	                		<Narrative>{ $description }</Narrative> 
	                	)else() 
                	)
	             }            
                </gNARRATIVE2>
                <gCHEQUENUMBER>
                    <ChequeNumber>{ data($pagoDeCheque1/CHEQUE_NUMBER) }</ChequeNumber>
                </gCHEQUENUMBER>
            </TELLERFICOFCYCASHCHQType>
        </ns0:PagodeChequeFCY>
};

declare variable $pagoDeCheque1 as element(ns1:pagoDeCheque) external;
declare variable $accountCurrency as xs:string external;
declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $uuid as xs:string external;

xf:pagoDeChequeFcyIn($pagoDeCheque1,
    $accountCurrency,
    $username,
    $password,
    $uuid)
