#ifndef GPUDPBF
#define GPUDPBF
#pragma once

#include <iostream>
#include <queue>
#include <unordered_set>
#include <unordered_map>
#include <vector>

#include "device_launch_parameters.h"
#include <algorithm>
#include <cassert>
#include <fstream>
#include <sstream>
#include <vector>
#include <limits>
#include <stdio.h>
#include <string>
#include <ctime>
#include <graph_v_of_v_idealID/csr_graph.hpp>
#include "../include/graph_v_of_v_idealID/csr_graph.hpp"
#include <graph_hash_of_mixed_weighted/graph_hash_of_mixed_weighted.h>
#define CHECK(call)                                                         \
    do                                                                      \
    {                                                                       \
        const cudaError_t error_code = call;                                \
        if (error_code != cudaSuccess)                                      \
        {                                                                   \
            printf("CUDA Error:\n");                                        \
            printf("	File:		%s\n", __FILE__);                       \
            printf("	Line:		%d\n", __LINE__);                       \
            printf("	Error code:	%d\n", error_code);                     \
            printf("	Error text: %s\n", cudaGetErrorString(error_code)); \
            exit(1);                                                        \
        }                                                                   \
        else                                                                \
        {                                                                   \
            printf("CUDA success:\n");                                      \
        }                                                                   \
    } while (0);

#define THREAD_PER_BLOCK 512
#define LARGE_DEGREE 256
#define GRIDNUM 128
typedef struct non_overlapped_group_sets{
	std::vector<int> non_overlapped_group_sets_IDs_pointer_host, non_overlapped_group_sets_IDs;
	int length;
}non_overlapped_group_sets;
const int inf = 100000; 
typedef struct node
{
	int update = 0;
	int type;		// =0: this is the single vertex v; =1: this tree is built by grown; =2: built by merge
	int cost = inf; // cost of this tree T(v,p);
	int u,c=inf;			// if this tree is built by grown, then it's built by growing edge (v,u);
	int p1, p2;		// if this tree is built by merge, then it's built by merge T(v,p1) and T(v,p2);
} node;
struct records

{   int process_queue_num;
    int counts;
    int mid_process_queue_num;
    int mid_counts;
    double mid_time;
};
void DP_GPU(node **host_tree, node *host_tree_one_d, CSR_graph &graph, std::vector<int> &cumpulsory_group_vertices, graph_v_of_v_idealID &group_graph, graph_v_of_v_idealID &input_graph,int &real_cost, non_overlapped_group_sets s,double &rt,int &RAM,records &ret,int res_weight);
#endif