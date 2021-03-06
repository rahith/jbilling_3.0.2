/*
 * JBILLING CONFIDENTIAL
 * _____________________
 *
 * [2003] - [2012] Enterprise jBilling Software Ltd.
 * All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains
 * the property of Enterprise jBilling Software.
 * The intellectual and technical concepts contained
 * herein are proprietary to Enterprise jBilling Software
 * and are protected by trade secret or copyright law.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden.
 */

package com.sapienter.jbilling.server.process.task;

import java.util.Date;
import java.util.List;

import com.sapienter.jbilling.common.SessionInternalError;
import com.sapienter.jbilling.common.Util;
import com.sapienter.jbilling.server.order.db.OrderDTO;
import com.sapienter.jbilling.server.order.db.OrderProcessDAS;
import com.sapienter.jbilling.server.pluggableTask.BasicOrderPeriodTask;
import com.sapienter.jbilling.server.pluggableTask.TaskException;
import com.sapienter.jbilling.server.util.Constants;
import com.sapienter.jbilling.server.util.PreferenceBL;
import org.springframework.dao.EmptyResultDataAccessException;

public class ProRateOrderPeriodTask extends BasicOrderPeriodTask {

    protected Date viewLimit = null;

    //private static final Logger LOG = Logger
        //  .getLogger(ProRateOrderPeriodTask.class);

    public ProRateOrderPeriodTask() {
        viewLimit = null;
    }

    /**
     * This methods takes and order and calculates the end date that is going to
     * be covered cosidering the starting date and the dates of this process.
     * 
     * @param order
     * @param process
     * @param startOfBillingPeriod
     * @return
     * @throws SessionInternalError
     */
    public Date calculateEnd(OrderDTO order, Date processDate, int maxPeriods,
            Date periodStart) throws TaskException {

        // verify that the pro-rating preference is present
        PreferenceBL pref = new PreferenceBL();
        try {
            pref.set(order.getUser().getEntity().getId(),
                    Constants.PREFERENCE_USE_PRO_RATING);
        } catch (EmptyResultDataAccessException e1) {
            // the defaults are fine
        }
        if (pref.getInt() == 0) {
            throw new TaskException(
                    "This plug-in is only for companies with pro-rating enabled.");
        }

        return super.calculateEnd(order, processDate, maxPeriods,
                calculateCycleStarts(order, periodStart));

    }

    private Date calculateCycleStarts(OrderDTO order, Date periodStart) {
        Date retValue = null;
        List<Integer> results = new OrderProcessDAS().findActiveInvoicesForOrder(order.getId());
        if ( !results.isEmpty() && order.getNextBillableDay() != null) {
            retValue = order.getNextBillableDay();
        } else if (order.getCycleStarts() != null) {
            retValue = order.getCycleStarts();
        } else {
            retValue = periodStart;
        }

        return Util.truncateDate(retValue);
    }

}
