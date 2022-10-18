# Udiddit, A Social News Aggregator

## Project Introduction:
Udiddit is a social news aggregator, content rating, and discussions website. On Udiddit, registered users are able to link to external content or post their own text content about various topics, ranging from common topics such as photography and food, to more arcane ones such as horse masks or birds with arms. In turn, other users can comment on these posts, and each user is allowed to cast a vote about each post, either in an up (like) or down (dislike) direction.

Unfortunately, due to some time constraints before the initial launch of the site, the data model stored in Postgres hasn’t been well thought out, and is starting to show its flaws. You’ve been brought in for two reasons: first, to make an assessment of the situation and take steps to fix all the issues with the current data model, and then, once successful, to improve the current system by making it more robust and adding some web analytics.

## Instructions
All your tasks are outlined in a single Google Docs document here, which you should make a copy from (do not request access). A Word version of this template has also been attached at the bottom of this page. To complete the project, you’ll have to make your own copy of this document to document your findings and steps. This document will constitute your final submission for the project.

You need to complete the following in the template:

Part I: Investigate the existing schema
Part II: Create the DDL for your new schema
Part III: Migrate the provided data
Project Workspace
Accompanying this document is a SQL Workspace, which contains a dump of all the current data Udiddit has been gathering. You’ll be able to use this workspace to test your queries against real-life data. There are two important things you need to know about this SQL Workspace:

The workspace will reset changes to the database after fifteen (15) minutes of being closed/inactive. It will only store a limited amount of your previous queries in the history bar at the top, so make sure to save your queries down outside of the workspace before you leave.
Some queries involving large amounts of data can take up to 10-15 seconds to execute.
The data is also attached at the bottom of this page in bad_db.sql if you'd like to use it outside of the workspace.

Project Rubric
Following the tasks in the Google Docs template should get you to a fully functioning project, but make sure to double-check your work against the requirements in the project rubric as well before you submit on the last page in this lesson.

Supporting Materials
bad_db.sql
Udiddit, A Social News Aggregator Student Starter Template
