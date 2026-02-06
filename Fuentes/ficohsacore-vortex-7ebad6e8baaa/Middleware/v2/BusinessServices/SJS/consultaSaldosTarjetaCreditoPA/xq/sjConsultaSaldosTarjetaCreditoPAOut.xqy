xquery version "2004-draft";
(:: pragma  parameter="$resultGroup" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:sjConsultaSaldosTarjetaCreditoResponse" location="../../consultaSaldosTarjetaCredito/xsd/sjConsultaSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$sjConsultaSaldosTC" element="ns0:sjConsultaSaldosTarjetaCredito" location="../../consultaSaldosTarjetaCredito/xsd/sjConsultaSaldosTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSaldosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSaldosTarjetaCredito/xq/sjConsultaSaldosTarjetaCreditoOut/";
declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace ns2 = "http://www.procesa.com/fdcs/ot";
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/osbConSaldosTCOffLine";
declare namespace ns4 = "http://www.ficohsa.com.hn/middleware.services/cashOpenToBuyInquiryTypes";

declare function xf:sjConsultaSaldosTarjetaCreditoPAOut($resultGroup as element(*), $sjConsultaSaldosTC as element(ns0:sjConsultaSaldosTarjetaCredito))
    as element(ns0:sjConsultaSaldosTarjetaCreditoResponse) {
    <ns0:sjConsultaSaldosTarjetaCreditoResponse>
    {
		let $rowBase :=  $sjConsultaSaldosTC/CARD_INFORMATION[ORG_TYPE = 'BASE']
		let $rowAlt:= $sjConsultaSaldosTC/CARD_INFORMATION[ORG_TYPE = 'ALT']
        let $orgBase := string($rowBase/ORG/text())
        let $orgAlt := string($rowAlt/ORG/text())
		let $accountInquiryL8VLBase := $resultGroup/ACCOUNT_INQUIRY_RESPONSES/ns1:AccountInquiryL8VLResponse[AZXAIO-ORG = $orgBase]
		let $accountInquiryL8VLAlt := $resultGroup/ACCOUNT_INQUIRY_RESPONSES/ns1:AccountInquiryL8VLResponse[AZXAIO-ORG = $orgAlt]
		let $balanceInquiryBase := $resultGroup/BALANCE_INQUIRY_RESPONSES/ns1:BalanceInquiryResponse[ARXBIO-ORG = $orgBase]
		let $balanceInquiryAlt := $resultGroup/BALANCE_INQUIRY_RESPONSES/ns1:BalanceInquiryResponse[ARXBIO-ORG = $orgAlt]
		let $CashOpenToBuyInquiryBase := $resultGroup/CASH_OPEN_TO_BUY_RESPONSES/ns4:cashOpenToBuyInquiryResponse[Org = $orgBase]
		let $CashOpenToBuyInquiryAlt := $resultGroup/CASH_OPEN_TO_BUY_RESPONSES/ns4:cashOpenToBuyInquiryResponse[Org = $orgAlt]
		let $OnlineInformationResponseBase := $resultGroup/ONLINE_INFORMATION_RESPONSES/ns2:OnlineInformationResponse[Org = $orgBase]
		let $OnlineInformationResponseAlt := $resultGroup/ONLINE_INFORMATION_RESPONSES/ns2:OnlineInformationResponse[Org = $orgAlt]
		let $ARXBIO-PMT-TOT-AMT-DUE-BASE := xs:decimal($balanceInquiryBase/ARXBIO-PMT-TOT-AMT-DUE)
		let $AZXAIO-AMT-MEMO-CR-BASE := xs:decimal($accountInquiryL8VLBase/AZXAIO-AMT-MEMO-CR)
		let $AZXAIO-PMT-CTD-BASE := xs:decimal($accountInquiryL8VLBase/AZXAIO-PMT-CTD)
		let $ARXBIO-PMT-TOT-AMT-DUE-ALT := xs:decimal($balanceInquiryAlt/ARXBIO-PMT-TOT-AMT-DUE)
		let $AZXAIO-AMT-MEMO-CR-ALT := xs:decimal($accountInquiryL8VLAlt/AZXAIO-AMT-MEMO-CR)
		let $AZXAIO-PMT-CTD-ALT := xs:decimal($accountInquiryL8VLAlt/AZXAIO-PMT-CTD)
		let $LCY_MIN_PAYMENT := $ARXBIO-PMT-TOT-AMT-DUE-BASE - $AZXAIO-AMT-MEMO-CR-BASE	
		let $LCY_TOTAL_PAYMENT := ($AZXAIO-PMT-CTD-BASE + $AZXAIO-AMT-MEMO-CR-BASE)
		return(
			if(not(empty($accountInquiryL8VLBase)) and not(empty($balanceInquiryBase)))then(  
				if($LCY_MIN_PAYMENT >= 0)then(
					<FCY_MIN_PAYMENT>{ data($LCY_MIN_PAYMENT) }</FCY_MIN_PAYMENT>
				)else(
					<FCY_MIN_PAYMENT>0</FCY_MIN_PAYMENT>
				)
			)else( 	
				<FCY_MIN_PAYMENT/>
			),
			if(not(empty($accountInquiryL8VLBase)))then(
				if($LCY_TOTAL_PAYMENT >= 0)then(
					<FCY_TOTAL_PAYMENT>{ data($LCY_TOTAL_PAYMENT)}</FCY_TOTAL_PAYMENT>
				)else(
					<FCY_TOTAL_PAYMENT>0</FCY_TOTAL_PAYMENT>
				)
			)else(
				<FCY_TOTAL_PAYMENT/>
			),
			if(not(empty($accountInquiryL8VLBase)))then(
					<CREDIT_LIMIT>{ data($accountInquiryL8VLBase/AZXAIO-CRLIM) }</CREDIT_LIMIT>,
					<CREDIT_LIMIT_CCY>USD</CREDIT_LIMIT_CCY>
			)else(
				<CREDIT_LIMIT/>,
				<CREDIT_LIMIT_CCY/>
			),
			<ns0:consultaSaldosTarjetaCreditoResponseType>
			{ 
				<ns0:consultaSaldosTarjetaCreditoResponseRecordType>
				{
					let $AZXAIO-PMT-PAST-DUE:= xs:decimal(data($accountInquiryL8VLBase/AZXAIO-PMT-PAST-DUE))
					let $AZXAIO-PMT-30DAYS:= xs:decimal(data($accountInquiryL8VLBase/AZXAIO-PMT-30DAYS))
					let $AZXAIO-PMT-60DAYS:= xs:decimal(data($accountInquiryL8VLBase/AZXAIO-PMT-60DAYS))
					let $AZXAIO-PMT-90DAYS:= xs:decimal(data($accountInquiryL8VLBase/AZXAIO-PMT-90DAYS))
					let $AZXAIO-PMT-120DAYS:=xs:decimal(data($accountInquiryL8VLBase/AZXAIO-PMT-120DAYS))
					let $AZXAIO-PMT-150DAYS:= xs:decimal(data($accountInquiryL8VLBase/AZXAIO-PMT-150DAYS))
					let $AZXAIO-PMT-180DAYS:= xs:decimal(data($accountInquiryL8VLBase/AZXAIO-PMT-180DAYS))
					let $AZXAIO-PMT-210DAYS:= xs:decimal(data($accountInquiryL8VLBase/AZXAIO-PMT-210DAYS))
					let $OVERDUE_BALANCE:= $AZXAIO-PMT-PAST-DUE + $AZXAIO-PMT-30DAYS +  $AZXAIO-PMT-60DAYS + $AZXAIO-PMT-90DAYS + $AZXAIO-PMT-120DAYS + $AZXAIO-PMT-150DAYS + $AZXAIO-PMT-180DAYS + $AZXAIO-PMT-210DAYS
					return(
					 
						 if(not(empty($accountInquiryL8VLBase)))then(
							<OVERDUE_BALANCE>{ $OVERDUE_BALANCE }</OVERDUE_BALANCE>
						)else(
							 <OVERDUE_BALANCE/>
						),
						if(not(empty($accountInquiryL8VLBase)))then(
							<FLOATING_BALANCE>{ data($accountInquiryL8VLBase/AZXAIO-AMT-MEMO-DB) }</FLOATING_BALANCE>
						)else(
							<FLOATING_BALANCE/>
						),
						if(not(empty($accountInquiryL8VLBase)))then(
							<PURCHASES_LIMIT>{ data($accountInquiryL8VLBase/AZXAIO-AVAIL-CREDIT) }</PURCHASES_LIMIT>
						)else(
							<PURCHASES_LIMIT/>
						),
						if(not(empty($accountInquiryL8VLBase)))then(
							<WITHDRAWAL_LIMIT>{ data($accountInquiryL8VLBase/AZXAIO-AVAIL-CREDIT-WO-OVL) }</WITHDRAWAL_LIMIT>
						)else(
							<WITHDRAWAL_LIMIT/>
						),
						if(not(empty($accountInquiryL8VLBase)))then(
							<PAYMENTS_TODAY>{ data($accountInquiryL8VLBase/AZXAIO-AMT-MEMO-CR) }</PAYMENTS_TODAY>
						)else(
							<PAYMENTS_TODAY/>
						),
						<CURRENT_BALANCE_EXTRA>0</CURRENT_BALANCE_EXTRA>,
						<CURRENT_BALANCE_INTRA>0</CURRENT_BALANCE_INTRA>,
						<ORG_TYPE>{ data($rowBase/ORG_TYPE) }</ORG_TYPE>		,
						<ORG>{ data($rowBase/ORG) }</ORG>	
					)
				}
				</ns0:consultaSaldosTarjetaCreditoResponseRecordType>
			}
		  </ns0:consultaSaldosTarjetaCreditoResponseType>
	
		)   	
	}      	
    </ns0:sjConsultaSaldosTarjetaCreditoResponse>
};

declare variable $resultGroup as element(*) external;
declare variable $sjConsultaSaldosTC as element(ns0:sjConsultaSaldosTarjetaCredito) external;

xf:sjConsultaSaldosTarjetaCreditoPAOut($resultGroup, $sjConsultaSaldosTC)