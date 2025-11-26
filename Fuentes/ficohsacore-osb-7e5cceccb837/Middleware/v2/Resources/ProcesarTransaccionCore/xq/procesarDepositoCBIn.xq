(:: pragma bea:global-element-parameter parameter="$procesarTransaccionCore" element="ns0:procesarTransaccionCore" location="../xsd/procesarTransaccionCoreTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:RetiroEfectivoTengo" location="../../../BusinessServices/T24/svcRegistraTransaccionTengo/xsd/scvRegistraTransaccionTengoTypes.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesarTransaccionCoreTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesarTransaccionCore/xq/procesarDepositoCBIn/";

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
declare function DividirFM($tramaparsear as xs:string, $parseo as xs:integer) as xs:string {
  let $trama := fn:tokenize($tramaparsear,"@FM")
  return ($trama[$parseo])
};
declare function getTxnReference($reference as xs:string)  as xs:string {      
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
declare function splitString($String as xs:string?, $length as xs:integer) as xs:string* {
  if (exists($String) and string-length($String) > $length) then 
    (substring($String,1,$length), splitString(substring($String,$length+1),$length)) 
  else $String
};

declare function xf:procesarDepositoCBIn($procesarTransaccionCore as element(ns0:procesarTransaccionCore))
    as element(ns1:RetiroEfectivoTengo) {
        <ns1:RetiroEfectivoTengo>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($procesarTransaccionCore/USER_CB)),'') }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($procesarTransaccionCore/USER_CB)),'') }</password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FUNDSTRANSFERRETAILINTSALEWSType>
                <TransactionType>{ data($procesarTransaccionCore/CODE_TRANSACTION_T24) }</TransactionType>
                <DebitAccount>{ data($procesarTransaccionCore/DEBIT_ACCOUNT) }</DebitAccount>
                <DebitCurrency>{ data($procesarTransaccionCore/DEBIT_CURRENCY) }</DebitCurrency>
                <DebitAmount>{ data($procesarTransaccionCore/DEBIT_AMOUNT) }</DebitAmount>
                <CreditAccount>{ data($procesarTransaccionCore/CREDIT_ACCOUNT) }</CreditAccount>
                <gPAYMENTDETAILS>
                    {
                      let $payerid:= fn:tokenize(data($procesarTransaccionCore/PAYMENT_DETAILS),"@FM")
        		      return(
                        for $nombre in splitString($payerid[1],34)
                		return
                			if(fn:string($nombre) != "") then (
                              <PaymentDetails>{ data($nombre) }</PaymentDetails>
                            ) else ()
                        )
                    }
                    {
                      let $payername:= fn:tokenize(data($procesarTransaccionCore/PAYMENT_DETAILS),"@FM")
        		      return(
                        for $nombre in tokenize($payername[2], '\|\|')
                		return
                		for $nombreAux in splitString(data($nombre),34)
                		return
                			if(fn:string($nombreAux) != "" and not( fn:contains($nombreAux,'[') and 
                														 fn:contains($nombreAux,']') )) then (
                              <PaymentDetails>{ data($nombre) }</PaymentDetails>
                            ) else ()
                        )
                    }
                </gPAYMENTDETAILS>
                <LRREFTENGO>{ data($procesarTransaccionCore/TRANSACTION_ID) }</LRREFTENGO>
            </FUNDSTRANSFERRETAILINTSALEWSType>
        </ns1:RetiroEfectivoTengo>
};

declare variable $procesarTransaccionCore as element(ns0:procesarTransaccionCore) external;

xf:procesarDepositoCBIn($procesarTransaccionCore)
