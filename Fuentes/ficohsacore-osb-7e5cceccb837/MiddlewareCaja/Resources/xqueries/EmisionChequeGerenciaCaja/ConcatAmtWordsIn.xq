(:: pragma bea:global-element-parameter parameter="$emisiondechqdegerenciaTTResponse" element="ns0:EmisiondechqdegerenciaTTResponse" location="../../xsds/EmisionChequeGerenciaCaja/EmisionChequeGerenciaCaja.xsd" ::)
(:: pragma  type="anyType" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/EmisionChequeGerenciaCaja/ConcatAmtWordsIn/";

declare function xf:ConcatAmtWordsIn($emisiondechqdegerenciaTTResponse as element(ns0:EmisiondechqdegerenciaTTResponse))
    as element(*)* {
    	<LRAMTWORDS>
    	{
	        for $LRAMTWORDS in $emisiondechqdegerenciaTTResponse/FUNDSTRANSFERType/gLRAMTWORDS/LRAMTWORDS
	        return
	           fn:string($LRAMTWORDS/text())
        }
        </LRAMTWORDS>
};

declare variable $emisiondechqdegerenciaTTResponse as element(ns0:EmisiondechqdegerenciaTTResponse) external;

xf:ConcatAmtWordsIn($emisiondechqdegerenciaTTResponse)