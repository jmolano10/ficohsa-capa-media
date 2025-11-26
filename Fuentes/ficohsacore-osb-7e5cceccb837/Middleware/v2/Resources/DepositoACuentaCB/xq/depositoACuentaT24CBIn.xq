(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElementsCB.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$depositoACuenta" element="ns1:depositoACuenta" location="../xsd/depositoACuentaCBTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:RetiroEfectivoTengo" location="../../../BusinessServices/T24/svcRegistraTransaccionTengo/xsd/scvRegistraTransaccionTengoTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/depositoACuentaCBTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/DepositoACuentaCB/xq/depositoACuentaT24CBIn/";

declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };
<<<<<<< HEAD
declare function getTxnReference($reference as xs:string)  as xs:string {      
=======
 
  declare function getTxnReference($reference as xs:string)  as xs:string {      
>>>>>>> master
		 let $refList := fn:tokenize($reference,"-")
		 let $Text:= fn:substring-after($reference,"-")
		 let $Count:=fn:count($refList)
		 let $CountCadenaDeudor:=string-length($Text)-string-length($refList[$Count])
		 let $Text2:=fn:substring($Text,1,fn:number($CountCadenaDeudor)-1)
		 let $CodigoDeudor:=fn:replace($Text2,"-","..")
		 let $NombreDeudor:=fn:replace(fn:substring-after($Text,$Text2),"-","")
		 let $NumeroTransaccion:=fn:concat(fn:string($refList[1]),"-",$CodigoDeudor,"-",$NombreDeudor)
		 return
		 if ($refList[1] ="DRF") then 
		     $NumeroTransaccion
		 else
		     $reference		 
 };
<<<<<<< HEAD
=======
 
 (: Se encarga de partir un string en una secuencia de string de determinado tamaño :)
>>>>>>> master
declare function splitString($String as xs:string?, $length as xs:integer) as xs:string* {
  if (exists($String) and string-length($String) > $length) then 
    (substring($String,1,$length), splitString(substring($String,$length+1),$length)) 
  else $String
};

declare function xf:depositoACuentaT24CBIn($cuentaDebito as xs:string,
    $tipoTransaccion as xs:string,
    $requestHeader as element(ns2:RequestHeader),
    $depositoACuenta as element(ns1:depositoACuenta))
    as element(ns0:RetiroEfectivoTengo) {
        <ns0:RetiroEfectivoTengo>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/UserName))
                    }
</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/Password))
                    }
</password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FUNDSTRANSFERRETAILINTSALEWSType>
                <TransactionType>{ $tipoTransaccion }</TransactionType>
                <DebitAccount>{ $cuentaDebito }</DebitAccount>
                <DebitCurrency>{ data($depositoACuenta/CURRENCY) }</DebitCurrency>
                <DebitAmount>{ data($depositoACuenta/DEPOSIT_ITEMS/DEPOSIT_ITEM[1]/AMOUNT) }</DebitAmount>
                <CreditAccount>{ data($depositoACuenta/ACCOUNT_NUMBER) }</CreditAccount>
                <gPAYMENTDETAILS>
                {
                	for $nombre in splitString(data($depositoACuenta/INSTRUCTING_PARTY/PAYER_ID),34)
                		return
                			if(fn:string($nombre) != "") then (
                				<PaymentDetails>{$nombre}</PaymentDetails>
                			) else ()
                }
                {
                	for $nombre in tokenize($depositoACuenta/INSTRUCTING_PARTY/PAYER_NAME, '\|\|')
                		return
                		for $nombreAux in splitString(data($nombre),34)
                		return
                			if(fn:string($nombreAux) != "" and not( fn:contains($nombreAux,'[') and 
                														 fn:contains($nombreAux,']') )) then (					 
                				<PaymentDetails>{fn:replace(getTxnReference(fn:string($nombreAux)),"/","")}</PaymentDetails>
                			) else ()        
                }
                </gPAYMENTDETAILS>
<<<<<<< HEAD
                <LRREFTENGO>{ data($depositoACuenta/INSTRUCTING_PARTY/TRANSACTION_UUID) }</LRREFTENGO>
=======
                <LRREFTENGO>{ data($depositoACuenta/INSTRUCTING_PARTY/TRANSACTION_ID_BC) }</LRREFTENGO>
>>>>>>> master
            </FUNDSTRANSFERRETAILINTSALEWSType>
        </ns0:RetiroEfectivoTengo>
};

declare variable $cuentaDebito as xs:string external;
declare variable $tipoTransaccion as xs:string external;
declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $depositoACuenta as element(ns1:depositoACuenta) external;

xf:depositoACuentaT24CBIn($cuentaDebito,
    $tipoTransaccion,
    $requestHeader,
    $depositoACuenta)
