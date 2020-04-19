# Licensed to Elasticsearch B.V under one or more agreements.
# Elasticsearch B.V licenses this file to you under the Apache 2.0 License.
# See the LICENSE file in the project root for more information

##
# Module Benchmarks contains components for end-to-end benchmarking of the Elasticsearch client.
#
module Benchmarks
	DEFAULT_WARMUPS = 0
	DEFAULT_REPETITIONS = 1_000
	DEFAULT_OPERATIONS = 1

	##
	# Represents the benchmarking action.
	#
	class Action
		attr_reader :action, :category, :warmups, :repetitions, :operations, :setup, :block

		def initialize(action:, category:, warmups:, repetitions:, operations:, setup:, block:)
			@action = action
			@category = category
			@warmups = warmups         || DEFAULT_WARMUPS
			@repetitions = repetitions || DEFAULT_REPETITIONS
			@operations = operations   || DEFAULT_OPERATIONS
			@setup = setup
			@block = block
		end
	end

	##
	# Registers an action for benchmarking.
	#
	# @option arguments [String] :action The name of the measured action
	# @option arguments [String] :category The category of the measured action
	# @option arguments [Number] :warmups The number of warmup runs
	# @option arguments [Number] :repetitions The number of repetitions
	# @option arguments [Number] :operations The number of operations in a single repetition
	# @option arguments [Block]  :setup The operation setup
	# @option arguments [Block]  :block The measured operation
	#
	def self.register(arguments = {})
		self.actions << Action.new(
			action: arguments[:action],
			category: arguments[:category],
			warmups: arguments[:warmups],
			repetitions: arguments[:repetitions],
			operations: arguments[:operations],
			setup: arguments[:setup],
			block: arguments[:block]
		)
	end

	##
	# Set data path for benchmarks.
	#
	# @param path [Pathname,String]
	#
	def self.data_path=(path)
		@data_path = Pathname(path)
	end

	##
	# Return data path for benchmarks.
	#
	# @return [Pathname]
	#
	def self.data_path
		@data_path
	end

	##
	# Returns the registered actions.
	#
	# @return [Array]
	#
	def self.actions
		@actions ||= []
	end
end
