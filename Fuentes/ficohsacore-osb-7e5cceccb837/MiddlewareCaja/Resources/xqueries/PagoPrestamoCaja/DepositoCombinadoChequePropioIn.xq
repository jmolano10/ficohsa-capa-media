(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoPrestamo" element="ns0:pagoPrestamo" location="../../xsds/PagoPrestamoCaja/PagoPrestamoCaja.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Depositocombinado" location="../../xsds/Depositos/XMLSchema_-420276392.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoPrestamoCaja/DepositoCombinadoChequePropioIn/";

declare function xf:DepositoCombinadoChequePropioIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $pagoPrestamo as element(ns0:pagoPrestamo),
    $depositAccount as xs:string,
    $accountCurrency as xs:string,
    $uuid as xs:string)
    as element(ns1:Depositocombinado) {
        <ns1:Depositocombinado>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>{ $uuid }</messageId>
                <noOfAuth>0</noOfAuth>                
            </OfsFunction>
            <TELLERFINANCIALSERVICESFICOINPUTWSType>
                <DepositAccount>{ $depositAccount }</DepositAccount>
                <gTRANSACTION>
                    <mTRANSACTION>
                        <TRANSACTION>FICO.CHQ</TRANSACTION>
                        {
                            for $DEBIT_ACCOUNT in $pagoPrestamo/DEBIT_ACCOUNT
                            return
                                <SURROGATEAC>{ data($DEBIT_ACCOUNT) }</SURROGATEAC>
                        }
                        <CURRENCY>{ $accountCurrency }</CURRENCY>
                        <AMOUNT>{ data($pagoPrestamo/PAYMENT_AMOUNT) }</AMOUNT>
                        {
                            for $CHEQUE_NUMBER in $pagoPrestamo/CHEQUE_NUMBER
                            return
                                <CHEQUENUMBER>{ data($CHEQUE_NUMBER) }</CHEQUENUMBER>
                        }
                    </mTRANSACTION>
                </gTRANSACTION>
                {
                for $LOAN_NUMBER in $pagoPrestamo/LOAN_NUMBER
                    return
                    <LRLOANNO>{ fn:concat("PTM-",data($LOAN_NUMBER)) }</LRLOANNO>    
                }
                {
                	if (fn:substring(data($pagoPrestamo/LOAN_NUMBER), 1, 3) = '000') then
                		
                    		<LRMULTSFTTXN>322</LRMULTSFTTXN>
                    else
                    	 
                    		<LRMULTSFTTXN>298</LRMULTSFTTXN>
                }
            </TELLERFINANCIALSERVICESFICOINPUTWSType>
        </ns1:Depositocombinado>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoPrestamo as element(ns0:pagoPrestamo) external;
declare variable $depositAccount as xs:string external;
declare variable $accountCurrency as xs:string external;
declare variable $uuid as xs:string external;

xf:DepositoCombinadoChequePropioIn($autenticacionRequestHeader,
    $pagoPrestamo,
    $depositAccount,
    $accountCurrency,
    $uuid)