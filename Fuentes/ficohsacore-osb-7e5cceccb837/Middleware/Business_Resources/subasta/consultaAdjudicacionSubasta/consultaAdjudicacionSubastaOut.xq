(:: pragma bea:global-element-parameter parameter="$consultaadjudicacionsubastaResponse" element="ns1:ConsultaadjudicacionsubastaResponse" location="../Resources/XMLSchema_-1390898219.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaAdjudicacionSubastaResponse" location="consultaAdjudicacionSubastaTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaAdjudicacionSubastaTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaSubasta/consultaAdjudicacionSubasta/consultaAdjudicacionSubastaOut/";

declare function xf:consultaAdjudicacionSubastaOut($consultaadjudicacionsubastaResponse as element(ns1:ConsultaadjudicacionsubastaResponse))
    as element(ns0:consultaAdjudicacionSubastaResponse) {
        <ns0:consultaAdjudicacionSubastaResponse>
            <ns0:consultaAdjudicacionSubastaResponseType>
            {
            	let $PAPDATE := $consultaadjudicacionsubastaResponse/WSFICOPAPENQAAUCType[1]/gWSFICOPAPENQAAUCDetailType/mWSFICOPAPENQAAUCDetailType/PAPDATE
            	let $BIDDINGNUMBER := $consultaadjudicacionsubastaResponse/WSFICOPAPENQAAUCType[1]/gWSFICOPAPENQAAUCDetailType/mWSFICOPAPENQAAUCDetailType/BIDDINGNUMBER
            	let $AUCTIONVALUE := $consultaadjudicacionsubastaResponse/WSFICOPAPENQAAUCType[1]/gWSFICOPAPENQAAUCDetailType/mWSFICOPAPENQAAUCDetailType/AUCTIONVALUE
            	let $AWARDEDAMOUNT := $consultaadjudicacionsubastaResponse/WSFICOPAPENQAAUCType[1]/gWSFICOPAPENQAAUCDetailType/mWSFICOPAPENQAAUCDetailType/AWARDEDAMOUNT
            	let $REJECTEDAMOUNT := $consultaadjudicacionsubastaResponse/WSFICOPAPENQAAUCType[1]/gWSFICOPAPENQAAUCDetailType/mWSFICOPAPENQAAUCDetailType/REJECTEDAMOUNT
            	let $POSTAUCTIONREF := $consultaadjudicacionsubastaResponse/WSFICOPAPENQAAUCType[1]/gWSFICOPAPENQAAUCDetailType/mWSFICOPAPENQAAUCDetailType/POSTAUCTIONREF
            	for $item at $i in $POSTAUCTIONREF
            	return
                	<ns0:consultaAdjudicacionSubastaResponseRecordType>
                    	<AUCTION_DATE>{ data($PAPDATE[$i]) }</AUCTION_DATE>
                    	<AUCTION_NUMBER>{ data($BIDDINGNUMBER[$i]) }</AUCTION_NUMBER>
                    	<AMOUNT_REQUESTED>{ data($AUCTIONVALUE[$i]) }</AMOUNT_REQUESTED>
                    	<AMOUNT_AWARDED>{ data($AWARDEDAMOUNT[$i]) }</AMOUNT_AWARDED>
                    	<AMOUNT_REJECTED>{ data($REJECTEDAMOUNT[$i]) }</AMOUNT_REJECTED>
                    	<TRANSACTION_REFERENCE>{ data($POSTAUCTIONREF[$i]) }</TRANSACTION_REFERENCE>
                	</ns0:consultaAdjudicacionSubastaResponseRecordType>
            }
            </ns0:consultaAdjudicacionSubastaResponseType>
        </ns0:consultaAdjudicacionSubastaResponse>
};

declare variable $consultaadjudicacionsubastaResponse as element(ns1:ConsultaadjudicacionsubastaResponse) external;

xf:consultaAdjudicacionSubastaOut($consultaadjudicacionsubastaResponse)