xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/DetailsMovementsAccount";
(:: import schema at "../../../../ProviderServices/XSD/DetailsMovementsAccount/DetailsMovementsAccount_sp.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/accountMovements";
(:: import schema at "../../../../../MWBanking/Accounts/RequestorServices/XSD/getAccountMovementsTypes.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $GetAccountMovementsRequest as element() (:: schema-element(ns1:getAccountMovementsRequest) ::) external;
declare variable $monedaCuenta as xs:string external;
declare variable $nombreCuenta as xs:string external;
declare variable $MovimientosCuentaDetalladaResponse as element() (:: schema-element(ns2:OutputParameters) ::) external;
declare variable $ticket as xs:string external;
declare variable $uuid as xs:string external;
declare variable $accNumber as xs:string external;

declare function local:func($GetAccountMovementsRequest as element() (:: schema-element(ns1:getAccountMovementsRequest) ::), 
                            $monedaCuenta as xs:string, 
                            $nombreCuenta as xs:string, 
                            $MovimientosCuentaDetalladaResponse as element() (:: schema-element(ns2:OutputParameters) ::), 
                            $ticket as xs:string,
                            $uuid as xs:string,
                            $accNumber as xs:string) 
                            as element() (:: schema-element(ns1:getAccountMovementsResponse) ::) {
    <ns1:getAccountMovementsResponse>
        <StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{$uuid}</com:GlobalId>
        </StatusInfo>
        <AccountNumber>{fn:data($accNumber)}</AccountNumber>
        <AccountName>{fn:data($nombreCuenta)}</AccountName>
        <Currency>{fn:data($monedaCuenta)}</Currency>
        {
            if ($MovimientosCuentaDetalladaResponse/ns2:PV_STARTINGBALANCE)
            then <StartingBalance>{fn:data($MovimientosCuentaDetalladaResponse/ns2:PV_STARTINGBALANCE)}</StartingBalance>
            else ()
        }
        {
            if ($MovimientosCuentaDetalladaResponse/ns2:PV_ENDINGBALANCE)
            then <EndingBalance>{fn:data($MovimientosCuentaDetalladaResponse/ns2:PV_ENDINGBALANCE)}</EndingBalance>
            else ()
        }
        <StartDate>{fn:data($GetAccountMovementsRequest/BeginDate)}</StartDate>
        <EndDate>{fn:data($GetAccountMovementsRequest/EndDate)}</EndDate>
        {
            if ($MovimientosCuentaDetalladaResponse/ns2:PN_DEBITTOTAL)
            then <DebitCount>{fn:data($MovimientosCuentaDetalladaResponse/ns2:PN_DEBITTOTAL)}</DebitCount>
            else ()
        }
        {
            if ($MovimientosCuentaDetalladaResponse/ns2:PN_CREDITTOTAL)
            then <CreditCount>{fn:data($MovimientosCuentaDetalladaResponse/ns2:PN_CREDITTOTAL)}</CreditCount>
            else ()
        }
        {
            if ($MovimientosCuentaDetalladaResponse/ns2:PN_DEBITTOTALAMOUNT)
            then <DebitTotalAmount>{fn:data($MovimientosCuentaDetalladaResponse/ns2:PN_DEBITTOTALAMOUNT)}</DebitTotalAmount>
            else ()
        }
        {
            if ($MovimientosCuentaDetalladaResponse/ns2:PN_CREDITTOTALAMOUNT)
            then <CreditTotalAmount>{fn:data($MovimientosCuentaDetalladaResponse/ns2:PN_CREDITTOTALAMOUNT)}</CreditTotalAmount>
            else ()
        }
        <RecordsInfo>
            <InitialRecord>{fn:data($GetAccountMovementsRequest/PagingInfo/InitialRecord)}</InitialRecord>
            {
                if ($MovimientosCuentaDetalladaResponse/ns2:PN_TOTALRECORDSRETURNED)
                then <RecordsReturned>{fn:data($MovimientosCuentaDetalladaResponse/ns2:PN_TOTALRECORDSRETURNED)}</RecordsReturned>
                else ()
            }
            {
                if ($MovimientosCuentaDetalladaResponse/ns2:PN_TOTALRECORD)
                then <RecordsTotal>{fn:data($MovimientosCuentaDetalladaResponse/ns2:PN_TOTALRECORD)}</RecordsTotal>
                else ()
            }
            <Ticket>{fn:data($ticket)}</Ticket>
        </RecordsInfo>
        <ns1:getAccountMovementsResponseType>
        {
        let $vDates  := ($MovimientosCuentaDetalladaResponse/ns2:PT_BOOKINGDATE/ns2:PT_TYPEFILTER_ITEM)  
                    let $descrs  := ($MovimientosCuentaDetalladaResponse/ns2:PT_TRANSACTIONDESCRIPTION/ns2:PT_TRANSACTIONDESCRIPTION_ITEM)  
                    let $refs  := ($MovimientosCuentaDetalladaResponse/ns2:PT_REFNO/ns2:PT_REFNO_ITEM)  
                    let $docNros  := ($MovimientosCuentaDetalladaResponse/ns2:PT_CHEQUENUMBER/ns2:PT_REFNO_ITEM)  
                    let $txnReference  := ($MovimientosCuentaDetalladaResponse/ns2:PT_DEUDOR/ns2:PT_DEUDOR_ITEM)  
                    let $amounts  := ($MovimientosCuentaDetalladaResponse/ns2:PT_AMOUNT/ns2:PT_TYPEFILTER_ITEM)  
                    let $effectBal  := ($MovimientosCuentaDetalladaResponse/ns2:PT_EFFECTONBALANCE/ns2:PT_TRANSACTIONCODE_ITEM)  
                    let $inputter  := ($MovimientosCuentaDetalladaResponse/ns2:PT_INPUTTER/ns2:PT_TYPEFILTER_ITEM)  
                    let $txnCode  := ($MovimientosCuentaDetalladaResponse/ns2:PT_TRANSACTIONCODE/ns2:PT_TRANSACTIONCODE_ITEM)  
                    let $txnagnCode  := ($MovimientosCuentaDetalladaResponse/ns2:PT_AGENCYCODE/ns2:PT_TYPEFILTER_ITEM)  
                    let $txnagnName  := ($MovimientosCuentaDetalladaResponse/ns2:PT_AGENCYNAME/ns2:PT_DEUDOR_ITEM)  
                    let $txnDescriptionAll  := ($MovimientosCuentaDetalladaResponse/ns2:PT_CUSTOMERDESCRIPTION/ns2:PT_CUSTOMERDESCRIPTION_ITEM)  
                    let $authorizer  := ($MovimientosCuentaDetalladaResponse/ns2:PT_AUTHORIZER/ns2:PT_TYPEFILTER_ITEM)  
                    let $txnDateTime  := ($MovimientosCuentaDetalladaResponse/ns2:PT_VALUEDATE/ns2:PT_TYPEFILTER_ITEM)  
                    let $balance  := ($MovimientosCuentaDetalladaResponse/ns2:PT_RUNNINGBALANCE/ns2:PT_TYPEFILTER_ITEM)  
                    let $inicio  := (data($GetAccountMovementsRequest/PagingInfo/InitialRecord))  
                    let $contador  := ($MovimientosCuentaDetalladaResponse/ns2:PN_TOTALRECORDSRETURNED)  
                    let $BalanceInicial  := (xs:float(data($MovimientosCuentaDetalladaResponse/ns2:PV_STARTINGBALANCE)))  
                    return
                        for $i  in (1 to $contador)  
                        return
                          <ns1:getAccountMovementsResponseType>
                            <ValueDate>{ data($vDates[$i]) }</ValueDate>
                            <Description>{ data($descrs[$i]) }</Description>
                            <RefNo>{ data($refs[$i]) }</RefNo>
                            <DocumentNumber>{ data($docNros[$i]) }</DocumentNumber>
                            <TxnReference>{ data($txnReference[$i]) }</TxnReference>
                            <Amount>{ data($amounts[$i]) }</Amount>
                            <EfectOnBalance>{ data($effectBal[$i]) }</EfectOnBalance>
                            <Inputter>{ data($inputter[$i]) }</Inputter>
                            <TXNCode>{ data($txnCode[$i]) }</TXNCode>
                            <TXNAGNCode>{ data($txnagnCode[$i]) }</TXNAGNCode>
                            <TXNAGNName>{ data($txnagnName[$i]) }</TXNAGNName>
                            <TXNDescriptionall>{ data($txnDescriptionAll[$i]) }</TXNDescriptionall>
                            <Authoriser>{ data($authorizer[$i]) }</Authoriser>
                            <TXNDateATETIME>{ data($txnDateTime[$i]) }</TXNDateATETIME>
                            <RunningBalance>{data($balance[$i])}</RunningBalance>
                          </ns1:getAccountMovementsResponseType>
        }
        </ns1:getAccountMovementsResponseType>
    </ns1:getAccountMovementsResponse>
};

local:func($GetAccountMovementsRequest, $monedaCuenta, $nombreCuenta, $MovimientosCuentaDetalladaResponse, $ticket, $uuid, $accNumber)