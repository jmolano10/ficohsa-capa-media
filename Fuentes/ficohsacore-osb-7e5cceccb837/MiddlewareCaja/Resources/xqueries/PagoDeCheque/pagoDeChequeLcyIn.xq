(:: pragma bea:global-element-parameter parameter="$pagoDeCheque1" element="ns1:pagoDeCheque" location="../../xsds/PagoDeCheque/PagoDeCheque.xsd" ::)
(:: pragma bea:global-element-return element="ns0:PagodeChequeLCY" location="../../xsds/TransaccionesAutobancos/XMLSchema_1271081668.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoDeCheque";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoDeCheque/pagoDeChequeLcyIn/";

declare function xf:pagoDeChequeLcyIn($pagoDeCheque1 as element(ns1:pagoDeCheque),
    $username as xs:string,
    $password as xs:string,
    $uuid as xs:string)
    as element(ns0:PagodeChequeLCY) {
        <ns0:PagodeChequeLCY>
            <WebRequestCommon>
                <userName>{ $username }</userName>
                <password>{ $password }</password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>{ $uuid }</messageId>
            </OfsFunction>
            <TELLERFICOLCYCASHCHQType>
                <gACCOUNT1>
                    <mACCOUNT1>
                        <WithdrawalAmount>{ data($pagoDeCheque1/CHEQUE_AMOUNT) }</WithdrawalAmount>
                    </mACCOUNT1>
                </gACCOUNT1>
                <DebitAccount>{ data($pagoDeCheque1/ACCOUNT_NUMBER) }</DebitAccount>
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
                    <ChequeNo>{ data($pagoDeCheque1/CHEQUE_NUMBER) }</ChequeNo>
                </gCHEQUENUMBER>
            </TELLERFICOLCYCASHCHQType>
        </ns0:PagodeChequeLCY>
};

declare variable $pagoDeCheque1 as element(ns1:pagoDeCheque) external;
declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $uuid as xs:string external;

xf:pagoDeChequeLcyIn($pagoDeCheque1,
    $username,
    $password,
    $uuid)
