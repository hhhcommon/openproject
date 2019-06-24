#-- encoding: UTF-8

#-- copyright

# OpenProject is a project management system.
# Copyright (C) 2012-2018 the OpenProject Foundation (OPF)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2017 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See docs/COPYRIGHT.rdoc for more details.
#++
module BimSeeder
  module BasicData
    class WorkflowSeeder < ::BasicData::WorkflowSeeder
      def workflows
        types = Type.all
        types = types.map { |t| { t.name => t.id } }.reduce({}, :merge)

        new              = Status.find_by(name: I18n.t(:default_status_new))
        to_be_scheduled  = Status.find_by(name: I18n.t(:default_status_to_be_scheduled))
        scheduled        = Status.find_by(name: I18n.t(:default_status_scheduled))
        in_progress      = Status.find_by(name: I18n.t(:default_status_in_progress))
        closed           = Status.find_by(name: I18n.t(:default_status_closed))
        on_hold          = Status.find_by(name: I18n.t(:default_status_on_hold))
        rejected         = Status.find_by(name: I18n.t(:default_status_rejected))
        active           = Status.find_by(name: I18n.t('seeders.bim.default_status_active'))
        resolved         = Status.find_by(name: I18n.t('seeders.bim.default_status_resolved'))

        {
          types[I18n.t(:default_type_task)]                         => [new, in_progress, on_hold, rejected, closed],
          types[I18n.t(:default_type_milestone)]                    => [new, to_be_scheduled, scheduled, in_progress, on_hold, rejected, closed],
          types[I18n.t(:default_type_phase)]                        => [new, to_be_scheduled, scheduled, in_progress, on_hold, rejected, closed],
          types[I18n.t('seeders.bim.default_type_fault')]         => [active, resolved, closed],
          types[I18n.t('seeders.bim.default_type_clash')]         => [active, resolved, closed],
          types[I18n.t('seeders.bim.default_type_inquiry')]       => [active, resolved, closed],
          types[I18n.t('seeders.bim.default_type_issue')]         => [active, resolved, closed],
          types[I18n.t('seeders.bim.default_type_remark')]        => [active, resolved, closed],
          types[I18n.t('seeders.bim.default_type_request')]       => [active, resolved, closed]
        }
      end

      def type_seeder_class
        ::BimSeeder::BasicData::TypeSeeder
      end

      def status_seeder_class
        ::BimSeeder::BasicData::StatusSeeder
      end
    end
  end
end
