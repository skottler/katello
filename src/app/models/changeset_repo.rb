#
# Copyright 2011 Red Hat, Inc.
#
# This software is licensed to you under the GNU General Public
# License as published by the Free Software Foundation; either version
# 2 of the License (GPLv2) or (at your option) any later version.
# There is NO WARRANTY for this software, express or implied,
# including the implied warranties of MERCHANTABILITY,
# NON-INFRINGEMENT, or FITNESS FOR A PARTICULAR PURPOSE. You should
# have received a copy of GPLv2 along with this software; if not, see
# http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
#

class ChangesetRepoValidator < ActiveModel::Validator
  def validate(record)
    from_env = record.changeset.environment.prior
    to_env   = record.changeset.environment
    product = Product.find(record.product_id)

    #package must be in one of the repositories in the source environment
    #the repository must belong to a product that is in both source and target environment

    if not (product.environments.include? from_env and product.environments.include? to_env)
      record.errors[:base] <<  _("Product of the repository '#{record.repo_id}' must belong to both source and target environment!")
    end

    idx = product.repos(from_env).index do |r| r.id == record.repo_id end
    record.errors[:base] <<  _("Repo '#{record.repo_id}' doesn't belong to the specified product!") if idx == nil
  end
end

class ChangesetRepo < ActiveRecord::Base

  belongs_to :changeset, :inverse_of=>:repos
  belongs_to :product
  validates :display_name, :length => { :maximum => 255 }
  validates_with ChangesetRepoValidator

end