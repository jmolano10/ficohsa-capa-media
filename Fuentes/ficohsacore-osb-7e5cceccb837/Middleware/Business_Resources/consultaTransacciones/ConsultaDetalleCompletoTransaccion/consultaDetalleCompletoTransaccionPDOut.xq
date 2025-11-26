(:: pragma bea:global-element-parameter parameter="$consultadetransaccionPDResponse1" element="ns1:ConsultadetransaccionPDResponse" location="../Resources/XMLSchema_-1217682313.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDetalleCompletoTransaccionResponse" location="consultaDetalleCompletoTransaccionTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleCompletoTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaTransacciones/ConsultaDetalleCompletoTransaccion/consultaDetalleCompletoTransaccionPDOut/";

declare function xf:consultaDetalleCompletoTransaccionPDOut($consultadetransaccionPDResponse1 as element(ns1:ConsultadetransaccionPDResponse))
    as element(ns0:consultaDetalleCompletoTransaccionResponse) {
        <ns0:consultaDetalleCompletoTransaccionResponse>
            <TYPE>PD</TYPE>
			<TRANSACTION_DESCRIPTION/>
         	<CUSTOMER_DESCRIPTION/>
         	<BOOKING_DATE/>
         	<VALUE_DATE/>
         	<CHEQUE_NUMBER/>
            {
                for $ACCOUNTNUMBER in $consultadetransaccionPDResponse1/FICOHNPDBALANCESVIRTUALType[1]/gFICOHNPDBALANCESVIRTUALDetailType/mFICOHNPDBALANCESVIRTUALDetailType[1]/ACCOUNTNUMBER
                return
                    <DEBIT_ACCOUNT>{ data($ACCOUNTNUMBER) }</DEBIT_ACCOUNT>
            }         	
            {
                for $SUMTOTALPAID in $consultadetransaccionPDResponse1/FICOHNPDBALANCESVIRTUALType[1]/gFICOHNPDBALANCESVIRTUALDetailType/mFICOHNPDBALANCESVIRTUALDetailType[1]/SUMTOTALPAID
                return
                    <DEBIT_AMOUNT>{ data($SUMTOTALPAID) }</DEBIT_AMOUNT>
            }
         	<DEBIT_CURRENCY/>
            <CREDIT_ACCOUNT/>
            <CREDIT_AMOUNT/>
         	<CREDIT_CURRENCY/>
         	<INPUTTER/>
         	<AUTHORIZER/>
         	<DETAILS>
	            <DETAIL_RECORD>
               		<LABEL>DAYS IN PD</LABEL>
					{
		                for $DAYSINPD in $consultadetransaccionPDResponse1/FICOHNPDBALANCESVIRTUALType[1]/gFICOHNPDBALANCESVIRTUALDetailType/mFICOHNPDBALANCESVIRTUALDetailType[1]/DAYSINPD
		                return
		                    <VALUE>{ data($DAYSINPD) }</VALUE>
		            }               		
            	</DETAIL_RECORD>
	            <DETAIL_RECORD>
               		<LABEL>CAPITAL</LABEL>
					{
		                for $CAPITAL in $consultadetransaccionPDResponse1/FICOHNPDBALANCESVIRTUALType[1]/gFICOHNPDBALANCESVIRTUALDetailType/mFICOHNPDBALANCESVIRTUALDetailType[1]/CAPITAL
		                return
		                    <VALUE>{ data($CAPITAL) }</VALUE>
		            }               		
            	</DETAIL_RECORD>
	            <DETAIL_RECORD>
               		<LABEL>INTEREST</LABEL>
					{
		                for $INTEREST in $consultadetransaccionPDResponse1/FICOHNPDBALANCESVIRTUALType[1]/gFICOHNPDBALANCESVIRTUALDetailType/mFICOHNPDBALANCESVIRTUALDetailType[1]/INTEREST
		                return
		                    <VALUE>{ data($INTEREST) }</VALUE>
		            }               		
            	</DETAIL_RECORD>
	            <DETAIL_RECORD>
               		<LABEL>INTEREST</LABEL>
					{
		                for $SUMTOTALPAID in $consultadetransaccionPDResponse1/FICOHNPDBALANCESVIRTUALType[1]/gFICOHNPDBALANCESVIRTUALDetailType/mFICOHNPDBALANCESVIRTUALDetailType[1]/SUMTOTALPAID
		                return
		                    <VALUE>{ data($SUMTOTALPAID) }</VALUE>
		            }               		
            	</DETAIL_RECORD>
         	</DETAILS>
         	<EXTERNAL_BEN_ACCOUNT/>
         	<CONTRACT_ID/>
            {
                for $SUMTOTALPAID in $consultadetransaccionPDResponse1/FICOHNPDBALANCESVIRTUALType[1]/gFICOHNPDBALANCESVIRTUALDetailType/mFICOHNPDBALANCESVIRTUALDetailType[1]/SUMTOTALPAID
                return
                    <TRANSACTION_AMOUNT>{ data($SUMTOTALPAID) }</TRANSACTION_AMOUNT>
            }
         	<COMMISSION_AMOUNT/>
         	<REMITTANCE_ID/>
         	<COLL_PAY_CODE/>
         	<CREDIT_CARD_NUMBER/>
         	<PARENT_REFERENCE/>
         	<LOAN_NUMBER/>            
        </ns0:consultaDetalleCompletoTransaccionResponse>
};

declare variable $consultadetransaccionPDResponse1 as element(ns1:ConsultadetransaccionPDResponse) external;

xf:consultaDetalleCompletoTransaccionPDOut($consultadetransaccionPDResponse1)