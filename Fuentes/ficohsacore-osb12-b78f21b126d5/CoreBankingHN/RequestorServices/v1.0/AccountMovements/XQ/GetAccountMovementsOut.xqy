xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/AccountInquiryT24/XMLSchema_378991004.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/accountMovements";
(:: import schema at "../../../../../MWBanking/Accounts/RequestorServices/XSD/getAccountMovementsTypes.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $GetAccountMovementsResponse as element() (:: schema-element(ns1:ConsultaMovimientosCuentaResponse) ::) external;
declare variable $StartDate as xs:string external;
declare variable $EndDate as xs:string external;
declare variable $FechaSalidaT24 as xs:string external;
declare variable $InicialRecord as xs:string external;
declare variable $ticket as xs:string external;
declare variable $uuid as xs:string external;
declare variable $accNumber as xs:string external;

declare function local:getTxnReference($reference as xs:string) as xs:string {
	let $refList := fn:tokenize($reference,"-")
	return
	if ($refList[1] = "DRF") then (
		fn:replace($refList[2],"!!","-")
	) else (
		$reference
	)
	
};

declare function local:func($GetAccountMovementsResponse as element() (:: schema-element(ns1:ConsultaMovimientosCuentaResponse) ::), 
                            $StartDate as xs:string, 
                            $EndDate as xs:string, 
                            $FechaSalidaT24 as xs:string, 
                            $InicialRecord as xs:string, 
                            $ticket as xs:string,
                            $uuid as xs:string,
                            $accNumber as xs:string) 
                            as element() (:: schema-element(ns2:getAccountMovementsResponse) ::) {
    <ns2:getAccountMovementsResponse>
        <StatusInfo>
            <com:Status>Success</com:Status>
            {
                if ($GetAccountMovementsResponse/Status/transactionId)
                then <com:TransactionId>{fn:data($GetAccountMovementsResponse/Status/transactionId)}</com:TransactionId>
                else ()
            }
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{$uuid}</com:GlobalId>
        </StatusInfo>{
            <AccountNumber>{fn:data($accNumber)}</AccountNumber>,
            if ($GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/ACNAME)
            then <AccountName>{fn:data($GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/ACNAME)}</AccountName>
            else (),
        

            if ($GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/ACCCY)
            then <Currency>{fn:data($GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/ACCCY)}</Currency>
            else (),

            if ($GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/STARTINGBALANCE)
            then <StartingBalance>{fn:data($GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/STARTINGBALANCE)}</StartingBalance>
            else (),

            if ($GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/ENDINGBALANCE)
            then <EndingBalance>{fn:data($GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/ENDINGBALANCE)}</EndingBalance>
            else (),

        <StartDate>{fn:data($StartDate)}</StartDate>,
        <EndDate>{fn:data($EndDate)}</EndDate>,

            if ($GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/NOOFDEBITS)
            then <DebitCount>{fn:data($GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/NOOFDEBITS)}</DebitCount>
            else (),

            if ($GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/NOOFCREDITS)
            then <CreditCount>{fn:data($GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/NOOFCREDITS)}</CreditCount>
            else (),

            if ($GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/DTOTALDAMOUNT)
            then <DebitTotalAmount>{fn:data($GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/DTOTALDAMOUNT)}</DebitTotalAmount>
            else (),

            if ($GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/DTOTALCAMOUNT)
            then <CreditTotalAmount>{fn:data($GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/DTOTALCAMOUNT)}</CreditTotalAmount>
            else (),
            
        <RecordsInfo>
            <InitialRecord>{fn:data($InicialRecord)}</InitialRecord>
            {
                if ($GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/NUMMOSTRADO)
                then <RecordsReturned>{fn:data($GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/NUMMOSTRADO)}</RecordsReturned>
                else ()
            }
            {
                if ($GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/TOTALREGISTRO)
                then <RecordsTotal>{fn:data($GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/TOTALREGISTRO)}</RecordsTotal>
                else ()
            }
            <Ticket>{fn:data($ticket)}</Ticket>
        </RecordsInfo>}
        <ns2:getAccountMovementsResponseType>
        {
          let $valueDates := $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/BOOKINGDATE
            	let $descriptions := $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/TXNDESCRIPTION
            	let $refNos := $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/TXNREFERENCE
            	let $chqNumbers := $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/CHEQUENUMBER
            	let $txnReference := $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/DEPOSITREF
            	let $txnCode := $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/TXNCODE
            	let $dAmount := $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/DAMOUNT
            	let $cAmount := $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/CAMOUNT
            	let $transactionCode := $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/TXNCODE
            	
            	let $inputter := $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/INPUTTER
            	let $txnAgnCode := $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/TXNAGNCODE
            	let $txnAgnName := $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/TXNAGNNAME
            	let $txnDescriptionAll := $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/TXNDESCRIPTIONALL
            	let $authoriser := $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/AUTHORISER
            	let $txnDatetime := $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/TXNDATETIME
            	let $balance := $GetAccountMovementsResponse/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/RBALANCE
            	
                return
    				for $i in (1 to count($refNos))
        			return
        				if ((data($transactionCode[$i]) != "" or
        					data($valueDates[$i]) != "" or
        					data($refNos[$i]) != "" or
        					data($dAmount[$i]) != "" or
        					data($cAmount[$i]) != "")  
        					and data($valueDates[$i]) >= $FechaSalidaT24
        					and not(data($valueDates[$i]) = $FechaSalidaT24 and fn:substring(data($refNos[$i]), 1, 2) = "DC")) then (
            <ns2:getAccountMovementsResponseType>
                <ValueDate>{ data($valueDates[$i]) }</ValueDate>
                <Description>{ data($descriptions[$i]) }</Description>
                <RefNo>{ data($refNos[$i]) }</RefNo>
                <DocumentNumber>{ data($chqNumbers[$i]) }</DocumentNumber>
                <TxnReference>{ local:getTxnReference(fn:string($txnReference[$i]/text())) }</TxnReference>
                <Amount>
                { 
                  if ($cAmount[$i] = "0.00") then (
                    data($dAmount[$i])
                  ) else (
                    data($cAmount[$i])
                  )
                }
                </Amount>
                <EfectOnBalance>1</EfectOnBalance>
                <Inputter>{ data($inputter[$i]) }</Inputter>
                <TXNCode>{ data($transactionCode[$i]) }</TXNCode>
                <TXNAGNCode>{ data($txnAgnCode[$i]) }</TXNAGNCode>
                <TXNAGNName>{ data($txnAgnName[$i]) }</TXNAGNName>
                <TXNDescriptionall>{ fn:concat(fn:replace(fn:string($txnReference[$i]/text()),"!!","-"),data($txnDescriptionAll[$i])) }</TXNDescriptionall>
                <Authoriser>{ data($authoriser[$i]) }</Authoriser>
                <TXNDateATETIME>{ data($txnDatetime[$i]) }</TXNDateATETIME>
                <RunningBalance>{ data($balance[$i]) }</RunningBalance>
            </ns2:getAccountMovementsResponseType>
            ) else ()
        }  
        </ns2:getAccountMovementsResponseType>
    </ns2:getAccountMovementsResponse>
};

local:func($GetAccountMovementsResponse, $StartDate, $EndDate, $FechaSalidaT24, $InicialRecord, $ticket, $uuid, $accNumber)