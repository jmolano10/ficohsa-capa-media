(:: pragma bea:global-element-parameter parameter="$consultadesubastaporadjudicarResponse" element="ns0:ConsultadesubastaporadjudicarResponse" location="../Resources/XMLSchema_-1390898219.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaadjudicacionsubastaResponse" element="ns0:ConsultaadjudicacionsubastaResponse" location="../Resources/XMLSchema_-1390898219.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultasubastaporenviaraBCHResponse" element="ns0:ConsultasubastaporenviaraBCHResponse" location="../Resources/XMLSchema_-1390898219.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaSolicitudSubastaResponse" location="consultaSolicitudSubastaTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaSolicitudSubastaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/subasta/consultaSolicitudSubasta/consultaSolicitudSubastaOut/";

declare function xf:consultaSolicitudSubastaOut($consultadesubastaporadjudicarResponse as element(ns0:ConsultadesubastaporadjudicarResponse),
    $consultaadjudicacionsubastaResponse as element(ns0:ConsultaadjudicacionsubastaResponse),
    $consultasubastaporenviaraBCHResponse as element(ns0:ConsultasubastaporenviaraBCHResponse))
    as element(ns1:consultaSolicitudSubastaResponse) {
        <ns1:consultaSolicitudSubastaResponse>
            <ns1:consultaSolicitudSubastaResponseType>
            {
            	let $AUCTIONDATES 		:= $consultasubastaporenviaraBCHResponse/WSFICOEAUCINPNAUType[1]/gWSFICOEAUCINPNAUDetailType/mWSFICOEAUCINPNAUDetailType/AUCTIONDATE
            	let $AUCTIONAMTUSDS		:= $consultasubastaporenviaraBCHResponse/WSFICOEAUCINPNAUType[1]/gWSFICOEAUCINPNAUDetailType/mWSFICOEAUCINPNAUDetailType/AUCTIONAMTUSD
            	let $AUCTIONEXCHRATES	:= $consultasubastaporenviaraBCHResponse/WSFICOEAUCINPNAUType[1]/gWSFICOEAUCINPNAUDetailType/mWSFICOEAUCINPNAUDetailType/AUCTIONEXCHRATE
            	let $DEBITACCTNOS		:= $consultasubastaporenviaraBCHResponse/WSFICOEAUCINPNAUType[1]/gWSFICOEAUCINPNAUDetailType/mWSFICOEAUCINPNAUDetailType/DEBITACCTNO
            	 return
            	 	for $AUCTIONDATE at $i in $AUCTIONDATES
            	 		return 
            	 			if(data($AUCTIONDATE) != "") then (
            	 				<ns1:consultaSolicitudSubastaResponseRecordType>
	            	 				<AUCTION_DATE>{ data($AUCTIONDATE) }</AUCTION_DATE>
	            	 				<AMOUNT_REQUESTED>{ data($AUCTIONAMTUSDS[$i]) }</AMOUNT_REQUESTED>
	            	 				<AUCTION_RATE>{ data($AUCTIONEXCHRATES[$i]) }</AUCTION_RATE>
	            	 				<DEBIT_ACCOUNT>{ data($DEBITACCTNOS[$i]) }</DEBIT_ACCOUNT>
	            	 				<AUCTION_STATUS>PREAUCTION</AUCTION_STATUS>
            	 				</ns1:consultaSolicitudSubastaResponseRecordType>
            	 			) else ()
			}            
            {
            	let $AUCTIONDATES 		:= $consultadesubastaporadjudicarResponse/WSFICOAUCINPBAWDType[1]/gWSFICOAUCINPBAWDDetailType/mWSFICOAUCINPBAWDDetailType/AUCTIONDATE
            	let $BIDDINGNUMBERS		:= $consultadesubastaporadjudicarResponse/WSFICOAUCINPBAWDType[1]/gWSFICOAUCINPBAWDDetailType/mWSFICOAUCINPBAWDDetailType/BIDDINGNUMBER
            	let $AUCTIONAMTUSDS		:= $consultadesubastaporadjudicarResponse/WSFICOAUCINPBAWDType[1]/gWSFICOAUCINPBAWDDetailType/mWSFICOAUCINPBAWDDetailType/AUCTIONAMTUSD
            	let $AUCTIONEXCHRATES	:= $consultadesubastaporadjudicarResponse/WSFICOAUCINPBAWDType[1]/gWSFICOAUCINPBAWDDetailType/mWSFICOAUCINPBAWDDetailType/AUCTIONEXCHRATE
            	let $DEBITACCTNOS		:= $consultadesubastaporadjudicarResponse/WSFICOAUCINPBAWDType[1]/gWSFICOAUCINPBAWDDetailType/mWSFICOAUCINPBAWDDetailType/DEBITACCTNO
            	 return
            	 	for $BIDDINGNUMBER at $i in $BIDDINGNUMBERS
            	 		return 
            	 			if(data($BIDDINGNUMBER) != "") then (
            	 				<ns1:consultaSolicitudSubastaResponseRecordType>
	            	 				<AUCTION_DATE>{ data($AUCTIONDATES[$i]) }</AUCTION_DATE>
	            	 				<AUCTION_NUMBER>{ data($BIDDINGNUMBER) }</AUCTION_NUMBER>
	            	 				<AMOUNT_REQUESTED>{ data($AUCTIONAMTUSDS[$i]) }</AMOUNT_REQUESTED>
	            	 				<AUCTION_RATE>{ data($AUCTIONEXCHRATES[$i]) }</AUCTION_RATE>
	            	 				<DEBIT_ACCOUNT>{ data($DEBITACCTNOS[$i]) }</DEBIT_ACCOUNT>
	            	 				<AUCTION_STATUS>INAUCTION</AUCTION_STATUS>
            	 				</ns1:consultaSolicitudSubastaResponseRecordType>
            	 			) else ()
			}
			{
            	let $PAPDATES	 		:= $consultaadjudicacionsubastaResponse/WSFICOPAPENQAAUCType[1]/gWSFICOPAPENQAAUCDetailType/mWSFICOPAPENQAAUCDetailType/PAPDATE
            	let $BIDDINGNUMBERS		:= $consultaadjudicacionsubastaResponse/WSFICOPAPENQAAUCType[1]/gWSFICOPAPENQAAUCDetailType/mWSFICOPAPENQAAUCDetailType/BIDDINGNUMBER
            	let $AUCTIONVALUES		:= $consultaadjudicacionsubastaResponse/WSFICOPAPENQAAUCType[1]/gWSFICOPAPENQAAUCDetailType/mWSFICOPAPENQAAUCDetailType/AUCTIONVALUE
            	let $AWARDEDAMOUNTS		:= $consultaadjudicacionsubastaResponse/WSFICOPAPENQAAUCType[1]/gWSFICOPAPENQAAUCDetailType/mWSFICOPAPENQAAUCDetailType/AWARDEDAMOUNT
            	let $REJECTEDAMOUNTS	:= $consultaadjudicacionsubastaResponse/WSFICOPAPENQAAUCType[1]/gWSFICOPAPENQAAUCDetailType/mWSFICOPAPENQAAUCDetailType/REJECTEDAMOUNT
            	let $AUCTIONEXCHRATES	:= $consultaadjudicacionsubastaResponse/WSFICOPAPENQAAUCType[1]/gWSFICOPAPENQAAUCDetailType/mWSFICOPAPENQAAUCDetailType/AUCTIONEXCHRATE
            	let $DEBITACCTNOS		:= $consultaadjudicacionsubastaResponse/WSFICOPAPENQAAUCType[1]/gWSFICOPAPENQAAUCDetailType/mWSFICOPAPENQAAUCDetailType/DEBITACCTNO
            	let $POSTAUCTIONREFS	:= $consultaadjudicacionsubastaResponse/WSFICOPAPENQAAUCType[1]/gWSFICOPAPENQAAUCDetailType/mWSFICOPAPENQAAUCDetailType/POSTAUCTIONREF
            	 return
            	 	for $PAPDATE at $i in $PAPDATES
            	 		return 
            	 			if(data($PAPDATE) != "") then (
            	 				<ns1:consultaSolicitudSubastaResponseRecordType>
	            	 				<AUCTION_DATE>{ data($PAPDATE) }</AUCTION_DATE>
	            	 				<AUCTION_NUMBER>{ data($BIDDINGNUMBERS[$i]) }</AUCTION_NUMBER>
	            	 				<AMOUNT_REQUESTED>{ data($AUCTIONVALUES[$i]) }</AMOUNT_REQUESTED>
	            	 				<AMOUNT_AWARDED>{ data($AWARDEDAMOUNTS[$i]) }</AMOUNT_AWARDED>
	            	 				<AMOUNT_REJECTED>{ data($REJECTEDAMOUNTS[$i]) }</AMOUNT_REJECTED>
	            	 				<AUCTION_RATE>{ data($AUCTIONEXCHRATES[$i]) }</AUCTION_RATE>
	            	 				<DEBIT_ACCOUNT>{ data($DEBITACCTNOS[$i]) }</DEBIT_ACCOUNT>
	            	 				<AUCTION_STATUS>POSTAUCTION</AUCTION_STATUS>
	            	 				<TRANSACTION_REFERENCE>{ data($POSTAUCTIONREFS[$i]) }</TRANSACTION_REFERENCE>
            	 				</ns1:consultaSolicitudSubastaResponseRecordType>
            	 			) else ()
			}
            </ns1:consultaSolicitudSubastaResponseType>
        </ns1:consultaSolicitudSubastaResponse>
};

declare variable $consultadesubastaporadjudicarResponse as element(ns0:ConsultadesubastaporadjudicarResponse) external;
declare variable $consultaadjudicacionsubastaResponse as element(ns0:ConsultaadjudicacionsubastaResponse) external;
declare variable $consultasubastaporenviaraBCHResponse as element(ns0:ConsultasubastaporenviaraBCHResponse) external;

xf:consultaSolicitudSubastaOut($consultadesubastaporadjudicarResponse,
    $consultaadjudicacionsubastaResponse,
    $consultasubastaporenviaraBCHResponse)